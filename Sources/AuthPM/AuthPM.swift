import Foundation
import PMNetworking

public class AuthPM {
    
    let appId: String
    
    
    init(appId: String) {
        self.appId = appId
        
    }
    
    let net = PMNetworking()
    
    public func getAllAvailableAuthButtons() -> [PMAuthButton] {
        
        
    }
    
}
