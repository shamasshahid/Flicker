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

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateTakenLabel: UILabel!
    @IBOutlet weak var dateUploadedLabel: UILabel!
    @IBOutlet weak var originalDimensionsLabel: UILabel!
    @IBOutlet weak var numberOfViewsLabel: UILabel!
    
    enum PhotoDetailStrings: String {
        case close = "Close"
    }
    
    var viewModel: PhotoDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateLabels()
        photoImageView.contentMode = .scaleAspectFit
        
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)

    }
    
    fileprivate func updateLabels() {
        originalDimensionsLabel.text = viewModel.imageDimensionsText
        numberOfViewsLabel.text = viewModel.numberOfViewsText
        dateTakenLabel.text = viewModel.dateTakenText
        dateUploadedLabel.text = viewModel.dateUploadedText
        titleLabel.text = viewModel.title
        setupImageView()
    }
    
    func setupImageView() {
        photoImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        photoImageView.sd_setImage(with: viewModel.originalURL, placeholderImage: #imageLiteral(resourceName: "placeholder"))
    }
}
