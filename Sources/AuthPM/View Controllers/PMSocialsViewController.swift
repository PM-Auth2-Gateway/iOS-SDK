//
//  PMSocialsViewController.swift
//  
//
//  Created by Yaroslav Hrytsun on 21.03.2021.
//

import UIKit

class PMSocialsViewController: UIViewController {
    
    let containerView = PMSocialsContainerView()
    let titleLabel = PMTitleLabel(textAlignment: .center, fontSize: 20)
    var tableView = PMSocialsTableView()
    let actionButton = PMButton(backgroundColor: .systemRed, title: "Cancel")
    var availableServices: AvailableServices?
    
    let padding: CGFloat = 20
    
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
        view.addSubview(containerView)
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(actionButton)
        
        configureContainerView()
        configureTitleLabel()
        configureTableView()
        configureActionButton()
    }
    
    
    func configureContainerView() {
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 310)
        ])
    }
    
    
    func configureTitleLabel() {
        titleLabel.text = "Select a Service"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            tableView.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -15)
        ])
    }
    
    
    func configureActionButton() {
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
    @objc func dismissVC() {
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SocialCell.reuseIdentifier, for: indexPath) as? SocialCell else { return UITableViewCell() }
        switch indexPath.section {
        case 0:
            cell.configure(backgroundColor: PMColors.google, logoImage: PMImages.google, text: "Sign in with Google")
        case 1:
            cell.configure(backgroundColor: PMColors.google, logoImage: PMImages.facebook, text: "Sign in with Facebook")
        default:
            break
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
}
