import UIKit
import MessageUI

final class ContactUsViewController: UIViewController, FormInputsHighlightable {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var infoTextView: UITextView!
    @IBOutlet private var submitButton: UIButton!
    @IBOutlet private var firstNameTextField: UITextField!
    @IBOutlet private var lastNameTextField: UITextField!
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var phoneNumberTextField: UITextField!
    @IBOutlet private var messageTextView: UITextView!
    @IBOutlet private var firstNameLabel: UILabel!
    @IBOutlet private var lastNameLabel: UILabel!
    @IBOutlet private var emailLabel: UILabel!
    @IBOutlet private var phoneNumberLabel: UILabel!
    @IBOutlet private var messageLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "CONTACT_US_NAV_TITLE".localized
        titleLabel.text = "CONTACT_US_TITLE".localized
        infoTextView.textWithLineSpacing("CONTACT_US_TEXT".localized, lineHeight: 21)
        firstNameLabel.text = "CONTACT_US_FIRST_NAME".localized
        lastNameLabel.text = "CONTACT_US_LAST_NAME".localized
        emailLabel.text = "CONTACT_US_EMAIL".localized
        phoneNumberLabel.text = "CONTACT_US_PHONE_NUMBER".localized
        messageLabel.text = "CONTACT_US_MESSAGE".localized
        submitButton.setTitle("CONTACT_US_SUBMIT".localized, for: .normal)

        setupInputViews([emailTextField, firstNameTextField, lastNameTextField, phoneNumberTextField])
        messageTextView.delegate = self
        messageTextView.setupBorder()
        infoTextView.textContainerInset = .zero
        infoTextView.textContainer.lineFragmentPadding = 0
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        submitButton.layer.cornerRadius = 4
    }

    @IBAction private func sendMessage(_ sender: UIButton) {
        guard MFMailComposeViewController.canSendMail() else {
            return
        }
         
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setSubject("CONTACT_US_SUBJECT".localized)
        mail.setToRecipients(["CONTACT_US_RECIPIENT".localized])
        
        let body = String(
            format: "CONTACT_US_TEMPLATE".localized,
            firstNameTextField.text ?? "",
            lastNameTextField.text ?? "",
            emailTextField.text ?? "",
            phoneNumberTextField.text ?? "",
            messageTextView.text ?? "")
        mail.setMessageBody(body, isHTML: false)
        
        present(mail, animated: true)
    }
}

extension ContactUsViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.highlightBorder()
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        textView.cancelHighlight()
    }
}

extension ContactUsViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
