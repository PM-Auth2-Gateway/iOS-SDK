//
//  NetworkServiceMock.swift
//  
//
//  Created by Yaroslav Hrytsun on 27.03.2021.
//

import Foundation
@testable import AuthPM

final class NetworkServiceMock: APIProvider {
    
    var getServiceListCallCounter = 0
    var getLinkComponentsCallCounter = 0
    var getUserProfileCallCounter = 0
    
    func getServiceList(byAppId appId: Int, then: @escaping AvailableServicesCompletion) {
        getServiceListCallCounter += 1
    }
    
    func getLinkComponents(byAppId appId: Int, socialId: Int, scheme: String, then: @escaping URLComponentsCompletion) {
        getLinkComponentsCallCounter += 1
    }
    
    func getUserProfile(byAppId appId: Int, state: String, then: @escaping UserProfileCompletion) {
        getUserProfileCallCounter += 1
    }
}
