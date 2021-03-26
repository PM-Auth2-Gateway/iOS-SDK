//
//  File.swift
//  
//
//  Created by Yaroslav Hrytsun on 21.03.2021.
//

import Foundation
import PMNetworking

class NetworkService: APIProvider {
    
    static let shared = NetworkService()
    private let networking = PMNetworking()
    private let urlString = "https://net-api-hbyuu.ondigitalocean.app/Socials"
    private let urlForLink = "https://net-api-hbyuu.ondigitalocean.app/Socials/auth-link"
    private let urlForProfile = "https://net-api-hbyuu.ondigitalocean.app/Profile/info"
    
    private init () {}

    func getServiceList(byAppId appId: Int, completion then: @escaping AvailableServicesCompletion) {
        guard let url = URL(string: urlString) else {
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
                           device: String,
                           completion then: @escaping URLComponentsCompletion) {
        guard let url = URL(string: urlForLink) else {
            then(.failure(.unableToComplete))
            return
        }
        let resource = Resource(url: url,
                                requestMethod: .POST(requestBody: ["social_id" : socialId, "device" : device]),
                                headers: ["App_id" : "\(appId)", "Content-Type" : "application/json"],
                                decodingType: URLComponentsForService.self,
                                customResponseCodeHandler: nil)
        networking.networkCall(with: resource, then: then)
    }
    
    func getUserProfile(byAppId appId: Int,
                        state: String,
                        then: @escaping UserProfileCompletion) {
        guard let url = URL(string: urlForProfile) else {
            then(.failure(.unableToComplete))
            return
        }
        let resource = Resource(url: url,
                                requestMethod: .POST(requestBody: ["session_id": state]),
                                headers: ["App_id" : "\(appId)", "Content-Type" : "application/json"],
                                decodingType: UserProfile.self,
                                customResponseCodeHandler: nil)
        networking.networkCall(with: resource, then: then)
    }
}


