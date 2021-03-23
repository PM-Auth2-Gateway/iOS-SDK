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
    let authUri: String
}

struct SocialId: Codable {
    let socialId: Int
    
    enum CodingKeys: String, CodingKey {
        case socialId = "social_id"
    }
}

// MARK: Get URL parts to get token from the Service

struct URLComponentsForService: Codable {
    
    let authUri: String
    let prompt: String
    //    “prompt”: “consent”,
    
    let responseType: String
    //    “response_type”: “code”,
    
    let clientId: String
    //    "client_id": “*******”,
    
    let scope: String
    //    “scope”: “****”,
    
    let accessType: String
    //    “access_type”: “*****” //???? для чого? почитати
    
    
    enum CodingKeys: String, CodingKey {
        case authUri = "auth_uri"
        case prompt
        case responseType = "responce_type"
        case clientId = "client_id"
        case scope
        case accessType = "access_type"
    }
}

