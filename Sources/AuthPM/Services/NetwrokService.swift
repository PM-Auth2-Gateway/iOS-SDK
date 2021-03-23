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
    
    func getServiceList(byAppId: String, then: @escaping (Result<AvailableServices, PMNetworkingError>) -> Void) {
        let url = URL(string: "https://net-api-hbyuu.ondigitalocean.app/Socials")!
        let resource = Resource(url: url, requestMethod: .GET, headers: ["App_id" : "1"], decodingType: AvailableServices.self, customResponseCodeHandler: nil)
        networking.networkCall(with: resource, then: then)
    }
    
}


