//
//  Responses.swift
//  
//
//  Created by Yaroslav Hrytsun on 19.03.2021.
//

import Foundation

public struct UserProfile: Codable {
    let id, firstName, lastName, email: String?
    let isVerifiedEmail: Bool?
    let photo, locale: String?
    let additionalInformation: [String : String]?
}



