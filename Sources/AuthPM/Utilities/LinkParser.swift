//
//  LinkParser.swift
//  
//
//  Created by Yaroslav Hrytsun on 24.03.2021.
//

import Foundation

enum LinkParser {

    static func getSocialUrl(from components: LinkComponents) -> URL? {
        print(components.authUri, components.clientId, components.redirectUri, components.responseType, components.scope, components.state)
        return URL(string: "https://accounts.google.com/o/oauth2/v2/auth?redirect_uri=https%3A%2F%2Fnet-api-hbyuu.ondigitalocean.app%2FWeatherForecast%2Ftest-close&prompt=consent&response_type=code&client_id=745438436013-3k3ljamgbn7bp1sogcvb6je8idtr4fcc.apps.googleusercontent.com&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.email")
    }
}

