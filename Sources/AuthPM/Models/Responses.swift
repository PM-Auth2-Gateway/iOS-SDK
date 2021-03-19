//
//  Responses.swift
//  
//
//  Created by Yaroslav Hrytsun on 19.03.2021.
//

import Foundation

// MARK: Get available services to authenticate

struct AvailableServices {
    let services: [Service]
}

struct Service {
    let id: String
    let name: String
}

// MARK: Get URL parts to get token from the Service

struct URLComponentsForService {
    
    let redirectUrl: String
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
        case redirectUrl = "auth_uri"
        case prompt
        case responseType = "responce_type"
        case clientId = "client_id"
        case scope
        case accessType = "access_type"
    }
}

