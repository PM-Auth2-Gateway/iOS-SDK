//
//  File.swift
//  
//
//  Created by Yaroslav Hrytsun on 21.03.2021.
//

import Foundation
import PMNetworking

protocol APIProvider {
    
    typealias Completion<T> = (Result<T, PMNetworkingError>) -> ()
    
    typealias AvailableServicesCompletion = Completion<AvailableServices>
    typealias URLComponentsCompletion = Completion<URLComponentsForService>
    
    func getServiceList(byAppId appId: Int, completion: @escaping AvailableServicesCompletion)
    func getLinkComponents(byAppId appId: Int,
                 socialId: Int,
                 device: String,
                 completion: @escaping URLComponentsCompletion)
}

class NetworkService: APIProvider {
    
    static let shared = NetworkService()
    private let networking = PMNetworking()
    private let urlString = "https://net-api-hbyuu.ondigitalocean.app/Socials"
    private let urlForLink = "https://net-api-hbyuu.ondigitalocean.app/Socials/auth-link"
    
    private init () {}

//    typealias Available = (Result<AvailableServices, PMNetworkingError>) -> Void
//    typealias URLComponents = (Result<URLComponentsForService, PMNetworkingError>) -> Void

    func getServiceList(byAppId appId: Int, completion then: @escaping AvailableServicesCompletion) {
        guard let url = URL(string: urlString) else {
            then(.failure(.unableToComplete))
            return
        }
        let resource = Resource(url: url, requestMethod: .GET, headers: ["App_id" : String(appId)], decodingType: AvailableServices.self, customResponseCodeHandler: nil)
        networking.networkCall(with: resource, then: then)
//        then(.success(AvailableServices(socials: [])))
    }
    
    func getLinkComponents(byAppId appId: Int, socialId: Int, device: String, completion then: @escaping URLComponentsCompletion) {
        guard let url = URL(string: urlForLink) else {
            then(.failure(.unableToComplete))
            return
        }
        let resource = Resource(url: url, requestMethod: .POST(requestBody: ["social_id" : socialId, "device" : device]), headers: ["App_id" : String(appId), "Content-Type" : "application/json"], decodingType: URLComponentsForService.self, customResponseCodeHandler: nil)
        networking.networkCall(with: resource, then: then)
    }
}


