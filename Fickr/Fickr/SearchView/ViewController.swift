//
//  ViewController.swift
//  Fickr
//
//  Created by Shamas on 10/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var viewModel: SearchViewModel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    let repo: Repository = DependencyRepository()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewModel = SearchViewModel(apiService: repo.getService(), apiRouter: repo.getURLRouter() as! SearchRouter)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewModel.makeSearchCall()
    }


}

