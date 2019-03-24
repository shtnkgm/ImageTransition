//
//  Function.swift
//  ImageTransition
//
//  Created by Shota Nakagami on 2019/03/24.
//  Copyright © 2019 Shota Nakagami. All rights reserved.
//

import Foundation

public func clamp<T: Comparable>(_ value: T, min minValue: T, max maxValue: T) -> T {
    return max(min(value, maxValue), minValue)
}
