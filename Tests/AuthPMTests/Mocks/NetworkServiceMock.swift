//
//  NetworkServiceMock.swift
//  
//
//  Created by Yaroslav Hrytsun on 27.03.2021.
//

import Foundation
@testable import AuthPM

final class NetworkServiceMock: APIProvider {
    
    private(set) var serviceListCallCounter = 0
    private(set) var linkComponentsCallCounter = 0
    private(set) var userProfileCallCounter = 0
    
    func getServiceList(byAppId appId: Int, then: @escaping AvailableServicesCompletion) {
        serviceListCallCounter += 1
    }
    
    func getLinkComponents(byAppId appId: Int, socialId: Int, scheme: String, then: @escaping URLComponentsCompletion) {
        linkComponentsCallCounter += 1
    }
    
    func getUserProfile(byAppId appId: Int, state: String, then: @escaping UserProfileCompletion) {
        userProfileCallCounter += 1
    }
    
    func clearCounters() {
        serviceListCallCounter = 0
        linkComponentsCallCounter = 0
        userProfileCallCounter = 0
    }
}
