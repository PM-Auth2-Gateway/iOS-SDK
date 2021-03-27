import UIKit
import PMNetworking

public protocol AuthPMDelegate: class {
    func didFinishAuthorization(with profile: UserProfile?)
}

protocol AuthProtocol {
    func getServiceList(with service: APIProvider)
    func authButtonAction()
}

public class AuthPM: AuthProtocol {
    private let appId: Int
    private let deepLinkingScheme: String
    private var availableServicesResponse: Result<AvailableServices, PMNetworkingError>?
    weak private var hostingViewController: UIViewController?
    weak private var delegate: AuthPMDelegate?
    
    public init(appId: Int, deepLinkingScheme: String, delegate: AuthPMDelegate) {
        self.appId = appId
        self.deepLinkingScheme = deepLinkingScheme
        self.delegate = delegate
        
        getServiceList(with: NetworkService.shared)
    }
    
    internal func getServiceList(with service: APIProvider) {
        service.getServiceList(byAppId: appId) { [weak self] availableServicesResponse in
            guard let self = self else { return }
            self.availableServicesResponse = availableServicesResponse
        }
    }
    
    public func getAuthButton(toPresentInViewController hostingViewController: UIViewController) -> PMAuthButton {
        self.hostingViewController = hostingViewController
        let authButton = PMAuthButton()
        authButton.addTarget(self, action: #selector(authButtonAction), for: .touchUpInside)
        return authButton
    }
    
    @objc internal func authButtonAction() {
        switch availableServicesResponse {
        case .success(let services):
            presentSocialsVC(with: services)
        case .failure(let error):
            getServiceList(with: NetworkService.shared)
            presentErrorAlert(with: error)
        case .none:
            return
        }
    }
    
    private func presentSocialsVC(with services: AvailableServices) {
        if let delegate = delegate {
            let socialsViewController = PMSocialsViewController(availableServices: services,
                                                                appId: appId,
                                                                deepLinkingScheme: deepLinkingScheme,
                                                                delegate: delegate,
                                                                networkService: NetworkService.shared)
            hostingViewController?.present(socialsViewController, animated: true, completion: nil)
        }
    }
    
    private func presentErrorAlert(with error: PMNetworkingError) {
        let alertVC = PMAlertViewController(title: "Error",
                                            message: error.rawValue,
                                            buttonTitle: "OK")
        hostingViewController?.present(alertVC, animated: true, completion: nil)
    }
}
