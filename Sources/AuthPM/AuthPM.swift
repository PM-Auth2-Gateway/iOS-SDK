import UIKit
import PMNetworking

public class AuthPM {
    
    let appId: String
    
    
    public init(appId: String) {
        self.appId = appId
        
    }
    
    let net = PMNetworking()
    
    public func getAllAvailableAuthButtons() -> [PMAuthButton] {
        
        return [PMAuthButton(backgroundColor: .red, title: "Войти с помощью PM")]
    }
    
}
