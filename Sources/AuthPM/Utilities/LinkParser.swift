//
//  LinkParser.swift
//  
//
//  Created by Yaroslav Hrytsun on 24.03.2021.
//

import Foundation

enum LinkParser {

    static func getSocialUrl(from components: URLComponentsForService) -> URL? {
        let urlString = "\(components.authUri)"
            + "?client_id=\(components.clientId)"
            + "&redirect_uri=\(components.redirectUri)"
            + "&scope=\(components.scope.split(separator: " ").joined(separator: "+"))"
            + "&response_type=\(components.responseType)"
            + "&state=\(components.state)"        
        return URL(string: urlString)
    }
}

