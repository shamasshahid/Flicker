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

    enum PhotoDetailStrings: String {
        case close = "Close"
    }
    
    var viewModel: PhotoDetailViewModel!
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateTakenLabel: UILabel!
    @IBOutlet weak var dateUploadedLabel: UILabel!
    @IBOutlet weak var originalDimensionsLabel: UILabel!
    @IBOutlet weak var numberOfViewsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateLabels()
        photoImageView.contentMode = .scaleAspectFit
        
        let closeTitle = NSLocalizedString(PhotoDetailStrings.close.rawValue, comment: "")
        let barItem = UIBarButtonItem(title: closeTitle, style: .done, target: self, action: #selector(closeButtonTapped))
        navigationItem.leftBarButtonItem = barItem
    }
    
    @objc func closeButtonTapped() {
        self.presentingViewController?.dismiss(animated: true
            , completion: nil)
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
        photoImageView.sd_setImage(with: viewModel.originalURL, placeholderImage: #imageLiteral(resourceName: "placeholder"))
    }
}
