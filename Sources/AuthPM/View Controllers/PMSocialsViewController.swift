//
//  PMSocialsViewController.swift
//  
//
//  Created by Yaroslav Hrytsun on 21.03.2021.
//

import UIKit
import AuthenticationServices

class PMSocialsViewController: PMDataLoadingViewController {
    
    private let containerView = PMContainerView()
    private let titleLabel = PMTitleLabel(textAlignment: .center, fontSize: 20)
    private let tableView = PMSocialsTableView()
    private let actionButton = PMButton(backgroundColor: .systemRed, title: "Cancel")
    private var availableServices: AvailableServices?
    
    private let padding: CGFloat = 20
    
    init(availableServices: AvailableServices) {
        super.init(nibName: nil, bundle: nil)
        self.availableServices = availableServices
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
        
        let session = ASWebAuthenticationSession(url: URL(string: "https://net-api-hbyuu.ondigitalocean.app/WeatherForecast/test")!, callbackURLScheme: "pmacademy") { (url, error) in
            guard error == nil else {
                print(error!)
                return
            }
//            обработать url
        }

        session.presentationContextProvider = self
        session.start()
    }
}

extension PMSocialsViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return view.window!
    }
}
