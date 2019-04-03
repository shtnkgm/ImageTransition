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
    private let index: Int
    
    var nibDidLoad: () -> Void = {}
    
    init(item: Item, index: Int) {
        self.item = item
        self.index = index
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
        view.animationId = "\(index)_shadow"
        baseView.animationId = "\(index)_base"
        imageView.animationId = "\(index)_image"
        titleLabel.animationId = "\(index)_title"
        priceLabel.animationId = "\(index)_subtitle"
        
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
