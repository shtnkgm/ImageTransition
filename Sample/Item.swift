//
//  Item.swift
//  Sample
//
//  Created by Shota Nakagami on 2019/03/24.
//  Copyright © 2019 Shota Nakagami. All rights reserved.
//

import Foundation

struct Item {
    let title: String
    let imageName: String
    let price: Float
    
    var priceString: String {
        return String(format: "$%.2f", price)
    }
}

extension Item {
    init(title: String) {
        self.init(title: title, imageName: title, price: Float.random(in: 0..<5))
    }
}
