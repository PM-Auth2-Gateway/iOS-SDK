//
//  UIControl+Ext.swift
//  
//
//  Created by Yaroslav Hrytsun on 27.03.2021.
//

import UIKit

public extension UIControl {
    @objc static var debounceDelay: Double = 0.5
    
    @objc func debounce(delay: Double = UIControl.debounceDelay, siblings: [UIControl] = []) {
        
        let buttons = [self] + siblings
        buttons.forEach { $0.isEnabled = false }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            buttons.forEach { $0.isEnabled = true }
        }
     }
}
