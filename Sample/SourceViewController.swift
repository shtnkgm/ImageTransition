//
//  SourceViewController.swift
//  Sample
//
//  Created by Shota Nakagami on 2018/09/20.
//  Copyright © 2018年 Shota Nakagami. All rights reserved.
//

import UIKit
import ImageTransition

final class SourceViewController: UIViewController {
    @IBOutlet private weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewDidTapped))
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func imageViewDidTapped() {
        let destinationViewController = DestinationViewController.make()
        destinationViewController.transitioningDelegate = ImageTransitionDelegate.shared
        present(destinationViewController, animated: true, completion: nil)
    }
}

extension SourceViewController: ImageTransitionable {
    var imageViewForTransition: UIImageView? {
        return imageView
    }
}
