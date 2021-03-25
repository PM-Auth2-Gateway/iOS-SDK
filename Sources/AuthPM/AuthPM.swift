import UIKit
import PMNetworking

public class AuthPM {
    
    private let appId: Int
    private let deepLinkingScheme: String
    private var availableServicesResponse: Result<AvailableServices, PMNetworkingError>?
    private var urlComponentsResponse: Result<URLComponentsForService, PMNetworkingError>?
    private let authButton = PMButton(backgroundColor: .orange, title: "Sign In with PM")
    weak private var hostingViewController: UIViewController?
    
    public init(appId: Int, deepLinkingScheme: String) {
        self.appId = appId
        self.deepLinkingScheme = deepLinkingScheme
        
        NetworkService.shared.getServiceList(byAppId: appId) { [weak self] availableServicesResponse in
            guard let self = self else { return }
            self.availableServicesResponse = availableServicesResponse
        }
    }
    
    
    public func getAuthButton(toPresentInViewController hostingViewController: UIViewController) -> PMButton {
        self.hostingViewController = hostingViewController
        authButton.addTarget(self, action: #selector(authButtonAction), for: .touchUpInside)
        return authButton
    }
    
    
    @objc private func authButtonAction() {
        switch availableServicesResponse {
        case .success(let services):
            if services.socials.count > 0 {
                let socialsViewController = PMSocialsViewController(availableServices: services, appId: appId, deepLinkingScheme: deepLinkingScheme)
                hostingViewController?.present(socialsViewController, animated: true, completion: nil)
            } else {
                let alertVC = PMAlertViewController(title: "Error", message: "This app doesn't support any services to log in with.", buttonTitle: "OK")
                hostingViewController?.present(alertVC, animated: true, completion: nil)
            }
        case .failure(let error):
            let alertVC = PMAlertViewController(title: "Error", message: error.rawValue, buttonTitle: "OK")
            hostingViewController?.present(alertVC, animated: true, completion: nil)
        case .none:
            return
        }
    }    
}
