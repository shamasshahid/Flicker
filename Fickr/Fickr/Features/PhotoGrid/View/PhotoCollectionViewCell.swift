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
    
    static var cellWidth = 200
    static var cellHeight = 200
    static var reuseIdentifier = "image_collection_cell"
    
    @IBOutlet weak var imageView: UIImageView!
    
    var viewModel: PhotoCellViewModel? {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imageView.sd_setImage(with: viewModel?.getURL(), placeholderImage: #imageLiteral(resourceName: "placeholder"), options: [], context: nil)
    }
}
