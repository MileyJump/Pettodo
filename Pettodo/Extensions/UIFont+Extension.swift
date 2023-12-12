//
//  UIFont+Extension.swift
//  Pettodo
//
//  Created by Jung Hyun Kim on 2023/08/03.
//

import UIKit

extension UIFont {
    static func customFont(size: CGFloat) -> UIFont {
        if let font = UIFont(name: "GamjaFlower-Regular", size: size) {
            return font
        } else {
            return UIFont.systemFont(ofSize: size) // Fallback to system font
        }
    }
}
