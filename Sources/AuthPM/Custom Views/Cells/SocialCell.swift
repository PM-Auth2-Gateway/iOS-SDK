//
//  File.swift
//  
//
//  Created by Yaroslav Hrytsun on 21.03.2021.
//

import UIKit

class SocialCell: UITableViewCell {
    
    static let reuseIdentifier = "socialCell"
    
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
        titleLabel.text = "Sign in with \(serviceName)"
    }
    
    private func configure() {
        selectionStyle = .none
        contentView.layer.cornerRadius = 5
        contentView.addSubviews(logoImageView, titleLabel)
        contentView.backgroundColor = .systemGray5
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
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
