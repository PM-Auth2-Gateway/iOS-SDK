//
//  File.swift
//  
//
//  Created by Yaroslav Hrytsun on 21.03.2021.
//

import Foundation
import PMNetworking

class NetworkService {
    
    static let shared = NetworkService()
    private let networking = PMNetworking()
    
    private init () {}
    
    func getServiceList(byAppId: String, then: @escaping (AvailableServices) -> Void) {
        
//        let resource = Resource(url: , requestMethod: .GET, decodingType: [Social].self)
        then(AvailableServices(socials: [Social(id: 1, name: "Google"), Social(id: 2, name: "Facebook")]))
    }
    
}
