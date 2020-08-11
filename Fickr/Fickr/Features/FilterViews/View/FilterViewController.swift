//
//  FilterViewController.swift
//  Fickr
//
//  Created by Shamas on 10/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    var viewModel: FiltersViewModel!
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.dataSource = self
        
        let barItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        navigationItem.rightBarButtonItem = barItem
    }
    
    @objc func doneButtonTapped() {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filter_cell", for: indexPath)
        if let filterCell = cell as? FilterTableViewCell {
            let cellViewModel = viewModel.getFilterViewModelForCell(index: indexPath.row)
            filterCell.viewModel = cellViewModel
        }
        cell.textLabel?.text = viewModel.filters[indexPath.row]
        return cell
    }
    
    
}
