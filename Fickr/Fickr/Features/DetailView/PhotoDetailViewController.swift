//
//  PhotoDetailViewController.swift
//  Fickr
//
//  Created by Shamas on 11/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoDetailViewController: UIViewController {

    var viewModel: PhotoDetailViewModel!
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateTakenLabel: UILabel!
    @IBOutlet weak var dateUploadedLabel: UILabel!
    @IBOutlet weak var originalDimensionsLabel: UILabel!
    @IBOutlet weak var numberOfViewsLabel: UILabel!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateLabels()
    }
    
    fileprivate func updateLabels() {
        originalDimensionsLabel.text = viewModel.imageDimensionsText
        numberOfViewsLabel.text = viewModel.numberOfViewsText
        dateTakenLabel.text = viewModel.dateTakenText
        dateUploadedLabel.text = viewModel.dateUploadedText
        titleLabel.text = viewModel.title
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupImageView()
    }
    
    func setupImageView() {
        let maxAvailableHeight = view.frame.height - photoImageView.frame.origin.y - view.safeAreaInsets.bottom
        photoImageView.sd_setImage(with: viewModel.originalURL, placeholderImage: #imageLiteral(resourceName: "placeholder")) {[weak self] (downloadedImage, _, _, _) in
            self?.photoImageView.contentMode = .scaleAspectFit
            guard let image = downloadedImage, let imageView = self?.photoImageView, let constaint = self?.heightConstraint else {
                return
            }
            let ratio = image.size.width / image.size.height
            let newHeight = imageView.frame.width / ratio
            constaint.constant = min(newHeight, maxAvailableHeight)
            self?.view.layoutIfNeeded()
        }
    }
}
