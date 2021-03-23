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
    private let urlString = "https://net-api-hbyuu.ondigitalocean.app/Socials"
    private let urlForLink = "https://net-api-hbyuu.ondigitalocean.app/Socials/auth-link"
    typealias Available = (Result<AvailableServices, PMNetworkingError>) -> Void
    typealias URLComponents = (Result<URLComponentsForService, PMNetworkingError>) -> Void
    
    private init () {}
    
    func getServiceList(byAppId: String,
                        then: @escaping Available) {
        let url = URL(string: urlString)!
        
        let resource = Resource(url: url,
                                requestMethod: .GET,
                                headers: ["App_id" : "1"],
                                decodingType: AvailableServices.self,
                                customResponseCodeHandler: nil)
        networking.networkCall(with: resource, then: then)
    }
    
    func linkRequest(byAppId: String, then: @escaping URLComponents) {
        let url = URL(string: urlForLink)!
        let resource = Resource(url: url,
                                requestMethod: .POST(requestBody: ["social_id" : "1"]),
                                headers: ["App_id" : "1"],
                                decodingType: URLComponentsForService.self,
                                customResponseCodeHandler: nil)
        networking.networkCall(with: resource, then: then)
        print(resource)
    }
}
