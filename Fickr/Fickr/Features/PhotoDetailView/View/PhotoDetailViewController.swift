//
//  PhotoDetailViewController.swift
//  Fickr
//
//  Created by Shamas on 11/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import UIKit
import SDWebImage

//TODO: remove navigation controller and add action buttons on view itself
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
    
    fileprivate func setupNavigation() {
        let closeTitle = NSLocalizedString(PhotoDetailStrings.close.rawValue, comment: "")
        let barItem = UIBarButtonItem(title: closeTitle, style: .done, target: self, action: #selector(closeButtonTapped))
        navigationItem.leftBarButtonItem = barItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateLabels()
        //TODO: move to storyboard
        photoImageView.contentMode = .scaleAspectFit
        
        setupNavigation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupImageView()
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
    
    func setupImageView() {
        photoImageView.sd_setImage(with: viewModel.originalURL, placeholderImage: #imageLiteral(resourceName: "placeholder"))
    }
}
