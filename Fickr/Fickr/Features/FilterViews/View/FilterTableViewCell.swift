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
                self?.updateView()
            }
            setSelected(viewModel?.isSelected() ?? false, animated: true)
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {

        super.setSelected(selected, animated: animated)
        setAccessoryView(isSelected: selected)
    }

    func updateView() {
        filterLabel?.text = viewModel?.getFilterLabel()
        setAccessoryView(isSelected: viewModel?.isSelected() ?? false)
    }
    
    func setAccessoryView(isSelected: Bool) {
        accessoryType = isSelected ? .checkmark : .none
    }

}
