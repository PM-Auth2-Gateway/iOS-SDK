//
//  UserProfile.swift
//  
//
//  Created by Yaroslav Hrytsun on 19.03.2021.
//

import Foundation

public struct UserProfile: Codable {
    public let id: String?
    public let firstName: String?
    public let lastName: String?
    public let email: String?
    public let photo: String?
    public let locale: String?
    public let isVerifiedEmail: Bool?
    public let additionalInformation: [String : String]?
}



