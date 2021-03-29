//
//  File.swift
//  
//
//  Created by Yaroslav Hrytsun on 21.03.2021.
//

import Foundation
import PMNetworking

struct NetworkService: APIProvider {
    
    static let shared = NetworkService()
    private let networking = PMNetworking(defaultHeaders: ["Content-Type" : "application/json"])
    private let config = NetworkConfig(base: "https://net-api-hbyuu.ondigitalocean.app",
                                       socialsPath: "/Socials",
                                       authLinkPath: "/Socials/auth-link",
                                       profileLinkPath: "/Profile/info")
    
    private init () {}

    func getServiceList(byAppId appId: Int, then: @escaping AvailableServicesCompletion) {
        guard let url = URL(string: config.socialsURL) else {
            then(.failure(.unableToComplete))
            return
        }
        let resource = Resource(url: url,
                                requestMethod: .GET,
                                headers: ["App_id" : String(appId)],
                                decodingType: AvailableServices.self,
                                customResponseCodeHandler: nil)
        networking.networkCall(with: resource, then: then)
    }
    
    func getLinkComponents(byAppId appId: Int,
                           socialId: Int,
                           scheme: String,
                           then: @escaping URLComponentsCompletion) {
        guard let url = URL(string: config.authURL) else {
            then(.failure(.unableToComplete))
            return
        }
        let resource = Resource(url: url,
                                requestMethod: .POST(requestBody: ["social_id" : socialId, "device" : "\(scheme)://"]),
                                headers: ["App_id" : "\(appId)"],
                                decodingType: URLComponentsForService.self,
                                customResponseCodeHandler: nil)
        networking.networkCall(with: resource, then: then)
    }
    
    func getUserProfile(byAppId appId: Int,
                        state: String,
                        then: @escaping UserProfileCompletion) {
        guard let url = URL(string: config.profileURL) else {
            then(.failure(.unableToComplete))
            return
        }
        
        let resource = Resource(url: url,
                                requestMethod: .POST(requestBody: ["session_id": state]),
                                headers: ["App_id" : "\(appId)"],
                                decodingType: UserProfile.self, customResponseCodeHandler: nil)
        networking.networkCall(with: resource, then: then)
    }
}


