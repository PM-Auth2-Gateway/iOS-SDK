//
//  File.swift
//  
//
//  Created by spezza on 29.03.2021.
//

import Foundation

struct NetworkConfig {
    let base: String
    let socialsPath: String
    let authLinkPath: String
    let profileLinkPath: String
}

extension NetworkConfig {
    var socialsURL: String {
        base + socialsPath
    }
    
    var authURL: String {
        base + authLinkPath
    }
    
    var profileURL: String {
        base + profileLinkPath
    }
}
