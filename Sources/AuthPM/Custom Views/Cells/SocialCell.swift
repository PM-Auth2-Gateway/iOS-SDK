//
//  File.swift
//  
//
//  Created by Yaroslav Hrytsun on 21.03.2021.
//

import UIKit

class SocialCell: UITableViewCell {
    
    static let reuseIdentifier = "socialCell"
    
    private let backView = UIView()
    private let logoImageView = UIImageView()
    private let titleLabel = PMTitleLabel(textAlignment: .left, fontSize: 15)
    private let padding: CGFloat = 5
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(serviceName: String) {
        if serviceName == "Google" {
            logoImageView.image = PMImages.google
        } else if serviceName == "Facebook" {
            logoImageView.image = PMImages.facebook
        }
        titleLabel.text = "Sign in with ".localized() + serviceName
    }
    
    private func configure() {
        contentView.backgroundColor = .black
        backView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backView)
        selectionStyle = .none
        backView.layer.cornerRadius = 5
        backView.addSubviews(logoImageView, titleLabel)
        backView.backgroundColor = #colorLiteral(red: 0.07836129516, green: 0.08116482943, blue: 0.08142057806, alpha: 1)
            
        titleLabel.textColor = .white
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            logoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            logoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor, multiplier: 1),
            
            titleLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
    }
}
