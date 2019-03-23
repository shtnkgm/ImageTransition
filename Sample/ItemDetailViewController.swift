//
//  DestinationViewController.swift
//  Sample
//
//  Created by Shota Nakagami on 2018/09/20.
//  Copyright © 2018年 Shota Nakagami. All rights reserved.
//

import UIKit
import ImageTransition

final class ItemDetailViewController: UIViewController {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    private let dependency: Dependency
    
    struct Dependency {
        let image: UIImage
        let title: String
    }
    
    init(dependency: Dependency) {
        self.dependency = dependency
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = dependency.image
        titleLabel.text = dependency.title
        
        imageView.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewDidTapped))
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func imageViewDidTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension ItemDetailViewController: ImageTransitionable {
    var imageViewForTransition: UIImageView? {
        return imageView
    }
}
