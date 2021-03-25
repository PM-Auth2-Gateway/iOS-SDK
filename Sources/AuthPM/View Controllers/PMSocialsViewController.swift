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
    private let containerView = PMContainerView()
    private let titleLabel = PMTitleLabel(textAlignment: .center, fontSize: 20)
    private let tableView = PMSocialsTableView()
    private let actionButton = PMButton(backgroundColor: .systemRed, title: "Cancel")
    private var state: String?
    
    private let padding: CGFloat = 20
    
    init(availableServices: AvailableServices, appId: Int, deepLinkingScheme: String) {
        super.init(nibName: nil, bundle: nil)
        self.availableServices = availableServices
        self.appId = appId
        self.deepLinkingScheme = deepLinkingScheme
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addSubviews(containerView, titleLabel, tableView, actionButton)
        
        configureContainerView()
        configureTitleLabel()
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
    
    private func configureTitleLabel() {
        titleLabel.text = "Select a Service"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
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
        dismiss(animated: true)
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
        guard let availableServices = availableServices, let appId = appId else { return }
        showLoadingView()
        let socialId = availableServices.socials[indexPath.section].id
        NetworkService.shared.getLinkComponents(byAppId: appId, socialId: socialId, device: "mobile") { componentsResult in
            self.dismissLoadingView()
            do {
                let components = try componentsResult.get()
                self.state = components.state
                guard let url = LinkParser.getSocialUrl(from: components) else { throw "Error" }
                let session = ASWebAuthenticationSession(url: url, callbackURLScheme: self.deepLinkingScheme) { (url, error) in
                    guard error == nil else {
                        let alertVC = PMAlertViewController(title: "Authentication Error", message: "Authentication was interrupted. Please try again", buttonTitle: "OK")
                        self.present(alertVC, animated: true, completion: nil)
                        return
                    }
                    self.showLoadingView()
                    
                }
                session.presentationContextProvider = self
                DispatchQueue.main.async {
                    session.start()
                }
            }
            catch {
                DispatchQueue.main.async {
                    let alertVC = PMAlertViewController(title: "Something went wrong", message: "An error happened. Please try again.", buttonTitle: "OK")
                
                    self.present(alertVC, animated: true, completion: nil)
                }
            }
            
            //            обработать url
        }
    }
}

extension PMSocialsViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return view.window!
    }
}
