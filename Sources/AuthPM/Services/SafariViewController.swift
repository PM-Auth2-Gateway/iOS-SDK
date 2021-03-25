//
//  File.swift
//  
//
//  Created by spezza on 20.03.2021.
//

import Foundation
import SafariServices
import AuthenticationServices

class SafariLoginView: UIViewController, SFSafariViewControllerDelegate {
    
    @IBAction func openSafariViewController(_ sender: Any, url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        self.present(safariViewController, animated: true, completion: nil)
        safariViewController.delegate = self
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
