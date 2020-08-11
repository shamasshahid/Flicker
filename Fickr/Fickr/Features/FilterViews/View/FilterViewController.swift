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
        tableview.delegate = self
        tableview.allowsMultipleSelection = true
        tableview.allowsSelectionDuringEditing = true
        
        let barItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        navigationItem.rightBarButtonItem = barItem
    }
    
    @objc func doneButtonTapped() {
        viewModel.viewDismissing()
        self.presentingViewController?.dismiss(animated: true
            , completion: nil)
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

extension FilterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filter_cell", for: indexPath)
        if let filterCell = cell as? FilterTableViewCell {
            let cellViewModel = viewModel.getFilterViewModelForCell(index: indexPath.row)
            filterCell.viewModel = cellViewModel
            if let isSelected = cellViewModel?.isSelected(), isSelected {
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            } else {
                tableView.deselectRow(at: indexPath, animated: false)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            viewModel.changedSelectionCellAtRow(selection: cell.isSelected, index: indexPath.row)
        }
        
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        viewModel.changedSelectionCellAtRow(selection: false, index: indexPath.row)
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}
