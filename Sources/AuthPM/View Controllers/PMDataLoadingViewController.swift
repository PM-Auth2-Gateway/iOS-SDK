//
//  PMDataLoadingViewController.swift
//  
//
//  Created by Yaroslav Hrytsun on 23.03.2021.
//

import UIKit

class PMDataLoadingViewController: UIViewController {
    
    var activityContainerView: UIView!
    
    func showLoadingView() {
        activityContainerView = UIView(frame: view.bounds)
        view.addSubview(activityContainerView)
        
        activityContainerView.backgroundColor = .darkGray
        activityContainerView.alpha = 0
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        
        UIView.animate(withDuration: 0.25, delay: 0.5) {
            self.activityContainerView.alpha = 0.8
            self.activityContainerView.addSubview(activityIndicator)
        }
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .white
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: activityContainerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: activityContainerView.centerXAnchor)
        ])
        DispatchQueue.main.async {
            activityIndicator.startAnimating()            
        }
    }

    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.activityContainerView.removeFromSuperview()
            self.activityContainerView = nil
        }
    }
}
