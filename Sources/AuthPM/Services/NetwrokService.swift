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
//        then(.success(AvailableServices(socials: [])))
        let url = URL(string: "http://jsonplaceholder.typicode.com/socials")!
        let resource = Resource(url: url, requestMethod: .GET, decodingType: AvailableServices.self, customResponseCodeHandler: nil)
        networking.networkCall(with: resource, then: then)
//        then(AvailableServices(socials: [Social(id: 1, name: "Google"), Social(id: 2, name: "Facebook")]))
    }
    
}
