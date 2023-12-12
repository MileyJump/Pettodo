//
//  TabBarIndicator.swift
//  Pettodo
//
//  Created by Jung Hyun Kim on 2023/07/31.
//

import UIKit

extension UITabBarController {
    
    func addTabBarIndicator(index: Int, isFirstTime: Bool = false) {
        guard let tabView = tabBar.items?[index].value(forKey: "view") as? UIView else { return }
        
        let spacing: CGFloat = -2
        
        if !isFirstTime {
            if let existingUpperLineView = tabBar.subviews.first(where: { $0.tag == 999 }) {
                existingUpperLineView.removeFromSuperview()
            }
        }
        
        let upperLineView = UIView(frame: CGRect(x: tabView.frame.minX + spacing,
                                                 y: tabView.frame.minY + -1,
                                                 width: tabView.frame.size.width - spacing * 2,
                                                 height: 1.5))
        
        upperLineView.backgroundColor = .pettodoBrown
        upperLineView.tag = 999 // Setting a tag to identify the view later
        
        tabBar.addSubview(upperLineView)
    }
}


