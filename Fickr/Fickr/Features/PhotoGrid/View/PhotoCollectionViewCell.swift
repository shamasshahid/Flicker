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
    
    @IBOutlet weak var imageView: UIImageView!
    
    static let cellWidth = 200
    static let cellHeight = 200
    static let reuseIdentifier = "image_collection_cell"
    
    var viewModel: PhotoCellViewModel? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        roundImageView()
    }
    
    fileprivate func roundImageView() {
        
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func updateView() {
        
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imageView.sd_setImage(with: viewModel?.getURL(), placeholderImage: #imageLiteral(resourceName: "placeholder"), options: [], context: nil)
    }
}
