//
//  File.swift
//  
//
//  Created by spezza on 26.03.2021.
//

import Foundation
import PMNetworking

protocol APIProvider {
    
    typealias Completion<T> = (Result<T, PMNetworkingError>) -> ()
    
    typealias AvailableServicesCompletion = Completion<AvailableServices>
    typealias URLComponentsCompletion = Completion<URLComponentsForService>
    typealias UserProfileCompletion = Completion<UserProfile>
    
    func getServiceList(byAppId appId: Int, completion: @escaping AvailableServicesCompletion)
    
    func getLinkComponents(byAppId appId: Int,
                 socialId: Int,
                 device: String,
                 completion: @escaping URLComponentsCompletion)
    
    func getUserProfile(byAppId appId: Int,
                        state: String,
                        then: @escaping UserProfileCompletion)
}
