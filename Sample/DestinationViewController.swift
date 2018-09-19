//
//  DestinationViewController.swift
//  Sample
//
//  Created by Shota Nakagami on 2018/09/20.
//  Copyright © 2018年 Shota Nakagami. All rights reserved.
//

import UIKit
import ImageTransition

final class DestinationViewController: UIViewController {
    @IBOutlet private weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewDidTapped))
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    static func make() -> DestinationViewController {
        let storyBoard = UIStoryboard(name: "DestinationViewController", bundle: nil)
        let destinationViewController = storyBoard.instantiateInitialViewController()
        return destinationViewController as! DestinationViewController
    }
    
    @objc private func imageViewDidTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension DestinationViewController: ImageTransitionable {
    var imageViewForTransition: UIImageView? {
        return imageView
    }
}
