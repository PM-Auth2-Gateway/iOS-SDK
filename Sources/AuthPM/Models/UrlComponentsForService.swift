//
//  URLComponentsForService.swift
//  
//
//  Created by spezza on 24.03.2021.
//

import Foundation

struct URLComponentsForService: Codable {
    let authUri: String
    let redirectUri: String
    let responseType: String
    let clientId: String
    let scope: String
    let state: String
    
    enum CodingKeys: String, CodingKey {
        case authUri = "auth_uri"
        case redirectUri = "redirect_uri"
        case responseType = "response_type"
        case clientId = "client_id"
        case scope
        case state
    }
}
