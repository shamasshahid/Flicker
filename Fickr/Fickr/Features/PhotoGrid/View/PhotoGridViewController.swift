//
//  ViewController.swift
//  Fickr
//
//  Created by Shamas on 10/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import UIKit

///Starting view of the app. It displays grid of photo thumnails.
///User can search photos and filter results based on available tags.
class PhotoGridViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    static var detailSegueIdentifier = "show_detail"
    
    var viewModel: PhotoGridViewModel!
    let repo: Repository = PhotosRepository()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViewModel()
    }
    
    fileprivate func setupViewModel() {
        viewModel = PhotoGridViewModel(apiService: repo.getAPIService(), locationManager: repo.getLocationService())
        viewModel.onDataRefreshed = { [weak self] in
            self?.updateCollectionView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        searchBar.delegate = self
    }
    
    private func updateCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.contentOffset = CGPoint.zero
            self?.collectionView.reloadData()
        }
    }
    ///Preparing viewModels for navigating to either Filter selection screen OR PhotoDetail view from tapping onto thumbnail
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Create and assign the viewmodel
        
        if let destination = segue.destination as? FiltersViewController {

            destination.viewModel = viewModel.getFiltersVM()
            
        } else if let destination = segue.destination as? PhotoDetailViewController,
            let indexPath = sender as? IndexPath {
            
            destination.viewModel = viewModel.getDetailViewModelForIndex(index: indexPath.row)
        }
    }
}

extension PhotoGridViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        viewModel.searchString = searchBar.text
    }
}

extension PhotoGridViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let rowIndices = indexPaths.map( { $0.row })
        viewModel.prefetchRequestedForIndices(indices: rowIndices)
    }
}

extension PhotoGridViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: PhotoCollectionViewCell.cellWidth, height: PhotoCollectionViewCell.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.rowCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath)
        
        if let photoCell = cell as? PhotoCollectionViewCell {
            photoCell.viewModel = viewModel.getModelForCellAt(index: indexPath.row)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: PhotoGridViewController.detailSegueIdentifier, sender: indexPath)
    }
}

