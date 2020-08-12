//
//  FilterTableViewCell.swift
//  Fickr
//
//  Created by Shamas on 10/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    static let reuseIdentifier = "filter_cell"
    
    @IBOutlet weak var filterLabel: UILabel!
    
    var viewModel: FilterCellViewModel? {
        didSet {
            viewModel?.onFilterStateChanged = { [weak self] in
                self?.setAccessoryView(isSelected: self?.viewModel?.isSelected() ?? false)
            }
            
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func updateView() {
        filterLabel?.text = viewModel?.getFilterLabel()
        setAccessoryView(isSelected: viewModel?.isSelected() ?? false)
    }
    
    func setAccessoryView(isSelected: Bool) {
        accessoryType = isSelected ? .checkmark : .none
    }

}
