//
//  FilterTableViewCell.swift
//  Fickr
//
//  Created by Shamas on 10/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    var viewModel: FilterCellViewModel? {
        didSet {
            viewModel?.updateViewCallBack = { [weak self] in
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
        accessoryType = isSelected ? .checkmark : .none
    }

    func updateView() {
        textLabel?.text = viewModel?.getFilterLabel()
        accessoryType = (viewModel?.isSelected() ?? false) ? .checkmark : .none
//        isSelected = viewModel?.isSelected() ?? false
    }

}
