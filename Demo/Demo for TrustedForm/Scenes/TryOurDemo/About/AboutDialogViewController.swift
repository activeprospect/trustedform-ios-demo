import UIKit
import MessageUI

final class AboutDialogViewController: UIViewController {
    @IBOutlet private weak var okButton: UIButton!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var dismissButton: UIButton!
    @IBOutlet private weak var websiteButton: UIButton!
    @IBOutlet private weak var emailButton: UIButton!
    @IBOutlet private weak var privacyPolicyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        addActions()
    }
    
    private func setupLayout() {
        containerView.layer.cornerRadius = 6
        containerView.clipsToBounds = true
        okButton.layer.cornerRadius = 6
    }
    
    private func addActions() {
        dismissButton.addTarget(self, action: #selector(dismissAnimated), for: .touchUpInside)
        okButton.addTarget(self, action: #selector(dismissAnimated), for: .touchUpInside)
        
        emailButton.addTarget(self, action: #selector(openEmail), for: .touchUpInside)
        privacyPolicyButton.addTarget(self, action: #selector(openPrivacyPolicy), for: .touchUpInside)
        websiteButton.addTarget(self, action: #selector(openWebsite), for: .touchUpInside)
    }

    @objc
    private func dismissAnimated() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func openEmail() {
        let recipientEmailAddress = Constants.emailAddress
        
        if MFMailComposeViewController.canSendMail() {
            let composerController = MFMailComposeViewController()
            composerController.mailComposeDelegate = self
            composerController.setToRecipients([recipientEmailAddress])
            present(composerController, animated: true)
        } else if let emailUrl = URL(string: "mailto:" + Constants.emailAddress), UIApplication.shared.canOpenURL(emailUrl) {
            UIApplication.shared.open(emailUrl)
        } else {
            displayAlert(
                title: "ERROR_TITLE".localized,
                message: "TRY_OUR_DEMO_ABOUT_NO_EMAIL_CLIENT_ERROR".localized
            )
        }
    }
    
    @objc
    private func openPrivacyPolicy() {
        let privacyPolicyURL = Constants.URLs.privacyPolicy
        UIApplication.shared.open(privacyPolicyURL, options: [:], completionHandler: nil)
    }
    
    @objc
    private func openWebsite() {
        let websiteURL = Constants.URLs.website
        UIApplication.shared.open(websiteURL, options: [:], completionHandler: nil)
    }
}

extension AboutDialogViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
