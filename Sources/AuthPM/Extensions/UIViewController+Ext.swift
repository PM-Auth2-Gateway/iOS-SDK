//
//  File.swift
//  
//
//  Created by Yaroslav Hrytsun on 27.03.2021.
//

import UIKit

extension UIViewController {
    
    func presentPMAlertOnMainThread(title: String? = nil, message: String? = nil, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = PMAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
            self.present(alertVC, animated: true)
        }
    }
    
}
