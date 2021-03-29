//
//  String+Ext.swift
//  
//
//  Created by Yaroslav Hrytsun on 24.03.2021.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self,
                                 bundle: .module,
                                 comment: self)
    }
}
