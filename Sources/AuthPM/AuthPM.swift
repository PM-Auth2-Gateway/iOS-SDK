import UIKit
import PMNetworking

protocol Authorizator {
    var availableServices: AvailableServices? { get }
    
}

public class AuthPM: Authorizator {
    
    let appId: String
    private(set) var availableServices: AvailableServices?
    private let authButton: PMButton
    private var hostingViewController: UIViewController?
    
    public init(appId: String) {
        self.appId = appId
        authButton = PMButton(backgroundColor: .orange, title: "Sign In with PM")
        
        NetworkService.shared.getServiceList(byAppId: appId) { [weak self] availableServices in
            guard let self = self else { return }
            self.availableServices = availableServices
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
        guard let availableServices = availableServices else { return }
        let socialsViewController = PMSocialsViewController(availableServices: availableServices)
        hostingViewController?.present(socialsViewController, animated: true, completion: nil)
    }
    
//    public func getAllAvailableAuthButtons() -> [PMAuthButton] {
//
//
//    }
    
}
