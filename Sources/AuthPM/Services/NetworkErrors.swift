//
//  File 2.swift
//  
//
//  Created by spezza on 20.03.2021.
//

import Foundation

enum NetworkErrors: Error {
    case invalidStatusCode
    case thereIsNoToken
    case invalidUrl
    case networkError(Error)
    case invalidData
}
