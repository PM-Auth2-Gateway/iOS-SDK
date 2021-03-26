//
//  File.swift
//  
//
//  Created by spezza on 26.03.2021.
//

import UIKit

public class PMAuthButton: UIButton {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(backgroundColor: UIColor, title: String, image: UIImage) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 0)
        
        let imageView = UIImageView(image: image)
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            imageView.widthAnchor.constraint(equalToConstant: 70),
            imageView.heightAnchor.constraint(equalToConstant: 40),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

extension PMAuthButton {
    private func configure() {
        layer.cornerRadius = 10
        layer.borderWidth = 3
        layer.borderColor = UIColor.black.cgColor
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        setTitleColor(.black, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
}

