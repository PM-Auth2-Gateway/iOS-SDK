//
//  Responses.swift
//  
//
//  Created by Yaroslav Hrytsun on 19.03.2021.
//

import Foundation

// MARK: Get available services to authenticate

struct AvailableServices: Codable {
    let socials: [Social]
}

struct Social: Codable {
    let id: Int
    let name: String
}

// MARK: Get URL parts to get token from the Service

struct LinkComponents: Codable {
    
    let authUri: String
    let redirectUri: String
    let responseType: String
    let clientId: String
    let state: String
    let scope: String
    
    enum CodingKeys: String, CodingKey {
        case authUri = "auth_uri"
        case redirectUri = "redirect_uri"
        case responseType = "response_type"
        case clientId = "client_id"
        case scope
        case state
    }
}

