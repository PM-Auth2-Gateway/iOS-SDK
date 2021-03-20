//
//  File.swift
//  
//
//  Created by spezza on 20.03.2021.
//

import UIKit

public class popUpView: UIView {
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "Title of POPUP"
        return label
    }()
    
    fileprivate let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "Choose"
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    fileprivate let container: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .white
        container.layer.cornerRadius = 24
        
        return container
    }()
    
    fileprivate lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    @objc fileprivate func animateOut() {
        self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
        self.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.container.transform = .identity
            self.alpha = 1
        })
    }
    
    @objc fileprivate func animateIn() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
            self.alpha = 0
        }) { complete in
            if complete {
                self.removeFromSuperview()
            }
        }
    }
    
    
    // MARK: - ADD THIS TO YOUR ViewController in ViewDidLoad()
    // DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
    //    let popUp = popUpView()
    //    self.view.addSubview(popUpView)
    //}
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        self.frame = UIScreen.main.bounds
        
        self.addSubview(container)
        container.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45).isActive = true
        
        container.addSubview(stackView)
        //        stackView.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        //        stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.5).isActive = true
        
        animateIn()
        
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
