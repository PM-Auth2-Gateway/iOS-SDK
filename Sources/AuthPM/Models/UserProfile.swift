//
//  Responses.swift
//  
//
//  Created by Yaroslav Hrytsun on 19.03.2021.
//

import Foundation

struct UserProfile: Codable {
    let id, firstName, lastName, email: String
    let isVerifiedEmail: Bool
    let photo, locale: String
    let additionalInformation: AdditionalInformation
}

// MARK: - AdditionalInformation
struct AdditionalInformation: Codable {
    let additionalProp1, additionalProp2, additionalProp3: String
}


