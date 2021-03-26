//
//  File.swift
//  
//
//  Created by spezza on 24.03.2021.
//

import Foundation

struct AvailableServices: Codable {
    let socials: [Social]
}

struct Social: Codable {
    let id: Int
    let name: String
    let authUri: String
    let tokenUrl: String
    let logoPath: String
}
