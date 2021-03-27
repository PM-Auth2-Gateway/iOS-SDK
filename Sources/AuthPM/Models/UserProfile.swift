//
//  Responses.swift
//  
//
//  Created by Yaroslav Hrytsun on 19.03.2021.
//

import Foundation

public struct UserProfile: Codable {
    
    public let id, firstName, lastName, email, photo, locale: String?
    public let isVerifiedEmail: Bool?
    public let additionalInformation: [String : String]?
}



