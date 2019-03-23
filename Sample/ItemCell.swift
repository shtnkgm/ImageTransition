//
//  ItemCell.swift
//  Sample
//
//  Created by Shota Nakagami on 2019/03/24.
//  Copyright © 2019 Shota Nakagami. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {
    static let identifier = String(describing: ItemCell.self)
    
    @IBOutlet private(set) weak var imageView: UIImageView!
    @IBOutlet private(set) weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(image: UIImage?, title: String) {
        imageView.image = image
        titleLabel.text = title
    }
}
