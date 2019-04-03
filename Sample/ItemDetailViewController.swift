//
//  DestinationViewController.swift
//  Sample
//
//  Created by Shota Nakagami on 2018/09/20.
//  Copyright © 2018年 Shota Nakagami. All rights reserved.
//

import UIKit
import ImageTransition

final class ItemDetailViewController: UIViewController, UIViewControllerTransitioningDelegate {
    @IBOutlet private weak var baseView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    private let item: Item
    
    var nibDidLoad: () -> Void = {}
    
    init(item: Item) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nibDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.animationId = "shadow"
        baseView.animationId = "base"
        imageView.animationId = "image"
        titleLabel.animationId = "title"
        priceLabel.animationId = "subtitle"
        
        imageView.image = item.image
        titleLabel.text = item.title
        priceLabel.text = item.priceString
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(viewDidPan))
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc private func viewDidPan(gesture: UIPanGestureRecognizer) {
        ImageTransitionDelegate.shared.handleGesture(gesture, view: view)
        navigationController?.popViewController(animated: true)
    }
}
