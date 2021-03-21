import UIKit
import PMNetworking

protocol Authorizator {
    var socials: AvailableServices? { get }
    
}

public class AuthPM: Authorizator {
    
    let appId: String
    private(set) var socials: AvailableServices?
    private let authButton: PMButton
    private var hostingViewController: UIViewController?
    
    public init(appId: String) {
        self.appId = appId
        authButton = PMButton(backgroundColor: .orange, title: "Sign In with PM")
        
        NetworkService.shared.getServiceList(byAppId: appId) { [weak self] socials in
            guard let self = self else { return }
            self.socials = socials
        }
    }
    
    
    private func configureAuthButton() {
        
        
    }
    
    
    public func getAuthButton(toPresentInViewController hostingViewController: UIViewController) -> PMButton {
        self.hostingViewController = hostingViewController
        authButton.addTarget(self, action: #selector(presentSocialsViewController), for: .touchUpInside)
        return authButton
    }
    
    @objc private func presentSocialsViewController() {
        let socialsViewController = PMSocialsViewController()
        hostingViewController?.present(socialsViewController, animated: true, completion: nil)
    }
    
//    public func getAllAvailableAuthButtons() -> [PMAuthButton] {
//
//
//    }
    
}
