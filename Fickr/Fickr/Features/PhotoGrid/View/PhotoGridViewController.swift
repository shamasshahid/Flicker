//
//  ViewController.swift
//  Fickr
//
//  Created by Shamas on 10/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import UIKit

class PhotoGridViewController: UIViewController {
    
    static var detailSegueIdentifier = "show_detail"
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: PhotoGridViewModel!
    let repo: Repository = PhotosRepository()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViewModel()
    }
    
    fileprivate func setupViewModel() {
        viewModel = PhotoGridViewModel(apiService: repo.getService(), locationManager: LocationManager())
        viewModel.onDataRefreshed = { [weak self] in
            self?.updateCollectionView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViews()
    }
    
    private func setupViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
    }
    
    private func updateCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Create and assign the viewmodel
        let viewController = (segue.destination as? UINavigationController)?.viewControllers.first
        
        if let destination = viewController as? FilterViewController {
            
            destination.viewModel = viewModel.getFiltersVM()
            
        } else if let destination = viewController as? PhotoDetailViewController,
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

