//
//  Responses.swift
//  
//
//  Created by Yaroslav Hrytsun on 19.03.2021.
//

import Foundation





struct UserProfile: Codable {
    let id: String
    let accessToken: String
    let refreshToken: String
    let expiresIn: Int
    let firstName: String
    let lastName: String
    let email: String
    let isVerifiedEmail: String
    let photo: String
    let locale: String
}

