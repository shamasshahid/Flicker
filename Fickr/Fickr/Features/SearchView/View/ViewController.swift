//
//  ViewController.swift
//  Fickr
//
//  Created by Shamas on 10/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: SearchViewModel!
    let repo: Repository = DependencyRepository()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewModel = SearchViewModel(apiService: repo.getService(), apiRouter: repo.getURLRouter() as! SearchRouter)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewModel.dataRefreshed = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        viewModel.makeSearchCall(searchString: "sunny")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Create and assign the viewmodel r
        if let destination = (segue.destination as? UINavigationController)?.viewControllers.first as? FilterViewController {
            let filterModel = viewModel.getFiltersVM()
            destination.viewModel = filterModel
        }
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchString = searchBar.text, !searchString.isEmpty else {
            return
        }
        
        viewModel.makeSearchCall(searchString: searchString)
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200,height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.rowCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "image_collection_cell", for: indexPath)
        
        if let photoCell = cell as? PhotoCollectionViewCell {
            photoCell.viewModel = viewModel.getModelForCellIndex(index: indexPath.row)
        }
        
        return cell
    }
}

