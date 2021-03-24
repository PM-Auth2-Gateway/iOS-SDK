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
    
    func getServiceList(byAppId appId: Int, then: @escaping (Result<AvailableServices, PMNetworkingError>) -> Void) {
        guard let url = URL(string: "https://net-api-hbyuu.ondigitalocean.app/Socials") else {
            then(.failure(.unableToComplete))
            return
        }
        let resource = Resource(url: url, requestMethod: .GET, headers: ["App_id" : String(appId)], decodingType: AvailableServices.self, customResponseCodeHandler: nil)
        networking.networkCall(with: resource, then: then)
//        then(.success(AvailableServices(socials: [])))
    }
    
    
    func getLinkComponents(byAppId appId: Int, socialId: Int, device: String, then: @escaping (Result<LinkComponents, PMNetworkingError>) -> Void) {
        guard let url = URL(string: "https://net-api-hbyuu.ondigitalocean.app/Socials/auth-link") else {
            then(.failure(.unableToComplete))
            return
        }
        let resource = Resource(url: url, requestMethod: .POST(requestBody: ["social_id" : socialId, "device" : device]), headers: ["App_id" : String(appId), "Content-Type" : "application/json"], decodingType: LinkComponents.self, customResponseCodeHandler: nil)
        networking.networkCall(with: resource, then: then)
    }
    
    func linkRequest(byAppId: String, then: @escaping URLComponents) {
        
//        let encoder = JSONEncoder()
//        let components = ComponentsForService(components: [])
//        let data = try? encoder.encode(components)
//        let string = String(data: data, encoding: UTF8)
        
        let url = URL(string: urlForLink)!
        let resource = Resource(url: url,
                                requestMethod: .POST(requestBody: ["social_id" : "1"]),
                                headers: ["App_id" : "1"],
                                decodingType: URLComponentsForService,
                                customResponseCodeHandler: nil)
        networking.networkCall(with: resource, then: then)
    }
}


