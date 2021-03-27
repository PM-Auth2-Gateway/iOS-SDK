//
//  File.swift
//  
//
//  Created by Yaroslav Hrytsun on 27.03.2021.
//

import UIKit

extension UIViewController {
    
    func presentPMAlertOnMainThread(title: String, message: String, buttonTitle: String, onController: UIViewController) {
        DispatchQueue.main.async {
            let alertVC = PMAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
//            alertVC.modalPresentationStyle  = .overFullScreen
//            alertVC.modalTransitionStyle    = .crossDissolve
            onController.present(alertVC, animated: true)
        }
    }
}
