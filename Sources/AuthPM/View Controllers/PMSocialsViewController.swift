//
//  PMSocialsViewController.swift
//  
//
//  Created by Yaroslav Hrytsun on 21.03.2021.
//

import UIKit
import AuthenticationServices

class PMSocialsViewController: PMDataLoadingViewController {
    
    private var availableServices: AvailableServices?
    private var deepLinkingScheme: String?
    private var appId: Int?
    private var networkService: APIProvider?
    
    private var isLoading = false {
        didSet {
            DispatchQueue.main.async {
                self.tableView.isUserInteractionEnabled = !self.isLoading
            }
        }
    }
    
    private let containerView = PMContainerView()
    private let pmLogoImageView = UIImageView()
    private let tableView = PMSocialsTableView()
    private let actionButton = PMButton(title: "Cancel".localized())
    
    weak private var delegate: AuthPMDelegate?
    
    private let padding: CGFloat = 20
    
    init(availableServices: AvailableServices, appId: Int, deepLinkingScheme: String, delegate: AuthPMDelegate, networkService: APIProvider) {
        super.init(nibName: nil, bundle: nil)
        self.availableServices = availableServices
        self.appId = appId
        self.deepLinkingScheme = deepLinkingScheme
        self.delegate = delegate
        self.networkService = networkService
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addSubviews(containerView, pmLogoImageView, tableView, actionButton)
        
        configureContainerView()
        configurePmLogo()
        configureTableView()
        configureActionButton()
    }
    
    private func configureContainerView() {
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 310)
        ])
    }
    
    private func configurePmLogo() {
        pmLogoImageView.image = PMImages.pm
        pmLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        pmLogoImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            pmLogoImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            pmLogoImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            pmLogoImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            pmLogoImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: pmLogoImageView.bottomAnchor, constant: 15),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            tableView.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -15)
        ])
    }
    
    private func configureActionButton() {
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc private func dismissVC() {
        delegate?.didFinishAuthorization(with: nil)
        dismiss(animated: true)
    }
    
    private func getLinkComponents(byAppId appId: Int, socialId: Int, scheme: String) {
        guard let networkService = networkService else { return }
        networkService.getLinkComponents(byAppId: appId, socialId: socialId, scheme: scheme) { [weak self] componentsResult in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch componentsResult {
            case .success(let components):
                self.parseComponentsResult(with: components)
            case .failure(let error):
                self.presentPMAlertOnMainThread(message: error.rawValue, buttonTitle: "OK")
                self.isLoading = false
            }
        }
    }
    
    private func parseComponentsResult(with components: URLComponentsForService) {
        guard let url = LinkParser.getSocialUrl(from: components), let scheme = deepLinkingScheme else {
            presentPMAlertOnMainThread(buttonTitle: "OK")
            self.isLoading = false
            return
        }
        initiateAuthenticationSession(withState: components.state, url: url, scheme: scheme)
    }
    
    func initiateAuthenticationSession(withState state: String, url: URL, scheme: String) {
        let session = ASWebAuthenticationSession(url: url, callbackURLScheme: scheme) { [weak self] url, error in
            guard let self = self else { return }
            guard error == nil else {
                self.presentPMAlertOnMainThread(title: "Authentication Error", message: "Authentication was interrupted. Please try again", buttonTitle: "OK")
                self.isLoading = false
                return
            }
            self.showLoadingView()
            self.getUserProfile(withState: state)
        }
        session.presentationContextProvider = self
        DispatchQueue.main.async {
            session.start()
        }
    }
    
    func getUserProfile(withState state: String) {
        guard let appId = appId, let networkService = networkService else { return }
        networkService.getUserProfile(byAppId: appId, state: state) { [weak self] profileResult in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch profileResult {
            case .failure(let error):
                self.presentPMAlertOnMainThread(message: error.rawValue, buttonTitle: "OK")
            case .success(let userProfile):
                DispatchQueue.main.async {
                    self.delegate?.didFinishAuthorization(with: userProfile)
                }
            }
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
            self.isLoading = false
        }
        
    }
}

extension PMSocialsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let availableServices = availableServices else { return 0 }
        return availableServices.socials.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SocialCell.reuseIdentifier, for: indexPath) as? SocialCell, let availableServices = availableServices else { return UITableViewCell() }
        let service = availableServices.socials[indexPath.section]
        cell.configure(serviceName: service.name)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isLoading = true
        guard let availableServices = availableServices, let appId = appId, let deepLinkingScheme = deepLinkingScheme else { return }
        showLoadingView()
        let socialId = availableServices.socials[indexPath.section].id
        getLinkComponents(byAppId: appId, socialId: socialId, scheme: deepLinkingScheme)
    }
}

extension PMSocialsViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return view.window!
    }
}
