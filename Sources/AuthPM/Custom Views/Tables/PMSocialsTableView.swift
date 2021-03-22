//
//  PMSocialsTableView.swift
//  
//
//  Created by Yaroslav Hrytsun on 21.03.2021.
//

import UIKit

class PMSocialsTableView: UITableView {
    
    init() {
        super.init(frame: .zero, style: .plain)
        register(SocialCell.self, forCellReuseIdentifier: SocialCell.reuseIdentifier)
        rowHeight = 60
        tableFooterView = UIView(frame: .zero)
        separatorStyle = .none
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
