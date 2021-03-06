//
//  ContainerView.swift
//  
//
//  Created by Yaroslav Hrytsun on 21.03.2021.
//

import UIKit

class PMContainerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        backgroundColor = .black
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = UIColor.yellow.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
