//
//  ImageCollectionViewCell.swift
//  Fickr
//
//  Created by Shamas on 10/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell {
    
    var viewModel: PhotoCellViewModel? {
        didSet {
            updateView()
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    func updateView() {
        
        imageView.sd_setImage(with: viewModel?.getURL())
    }
    
}
