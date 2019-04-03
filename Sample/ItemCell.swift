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
    @IBOutlet private(set) weak var priceLabel: UILabel!
    
    var item: Item?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(item: Item) {
        self.item = item
        imageView.image = item.image
        titleLabel.text = item.title
        priceLabel.text = item.priceString
        
        imageView.layer.cornerRadius = 8
        
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 13
        
        clipsToBounds = false
        layer.shadowRadius = 20
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.25
    }
}
