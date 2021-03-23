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
        
        activityContainerView.backgroundColor = .systemBackground
        activityContainerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) { self.activityContainerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityContainerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: activityContainerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: activityContainerView.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.activityContainerView.removeFromSuperview()
            self.activityContainerView = nil
        }
    }
}
