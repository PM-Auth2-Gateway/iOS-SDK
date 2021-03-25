//
//  File.swift
//  
//
//  Created by spezza on 25.03.2021.
//

import Foundation

struct ProfileInfoError: Codable, Error {
    let error: String
    let errorDescription: String
    let errorReason: String
    
    enum CodingKeys: String, CodingKey {
        case error
        case errorDescription = "error_description"
        case errorReason = "error_reason"
    }
}
