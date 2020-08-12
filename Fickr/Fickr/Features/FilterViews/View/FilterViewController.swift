//
//  FilterViewController.swift
//  Fickr
//
//  Created by Shamas on 10/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    var viewModel: FiltersViewModel!
    
    enum FilerViewStrings: String {
        case done = "Done"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        
        let doneTitle = NSLocalizedString(FilerViewStrings.done.rawValue, comment: "")
        let barItem = UIBarButtonItem(title: doneTitle, style: .done, target: self, action: #selector(doneButtonTapped))
        navigationItem.rightBarButtonItem = barItem
    }
    
    fileprivate func setupTableView() {
        tableview.dataSource = self
        tableview.delegate = self
        tableview.allowsMultipleSelection = true
        tableview.allowsSelectionDuringEditing = true
    }
    
    @objc func doneButtonTapped() {
        self.presentingViewController?.dismiss(animated: true
            , completion: nil)
    }
}

extension FilterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.reuseIdentifier, for: indexPath)
        
        if let filterCell = cell as? FilterTableViewCell {
            let cellViewModel = viewModel.getFilterViewModelFor(index: indexPath.row)
            filterCell.viewModel = cellViewModel
            
            if let isSelected = cellViewModel?.isSelected(), isSelected {
                tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            } else {
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? FilterTableViewCell {
            updateCellForSelection(cell: cell, index: indexPath.row, isSelected: true)
        }
    }
    
    func updateCellForSelection(cell: FilterTableViewCell, index: Int, isSelected: Bool) {
        viewModel.updateSelectionAtIndex(selection: isSelected, index: index)
        let cellVM = viewModel.getFilterViewModelFor(index: index)
        cell.viewModel = cellVM
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? FilterTableViewCell {
            updateCellForSelection(cell: cell, index: indexPath.row, isSelected: false)
        }
    }
}
