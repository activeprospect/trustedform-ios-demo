import UIKit
import MessageUI

final class ContactUsViewController: UIViewController, FormInputsHighlightable, LoadingViewHandling {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var infoTextView: UITextView!
    @IBOutlet private var submitButton: SubmitButton!
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
    @IBOutlet private(set) weak var loadingView: UIView?
    
    private var networkingService: NetworkingProtocol = NetworkingService()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "CONTACT_US_NAV_TITLE".localized
        setTextfieldLabels()
        infoTextView.textWithLineSpacing("CONTACT_US_TEXT".localized, lineHeight: 21)
        submitButton.setTitle("CONTACT_US_SUBMIT".localized, for: .normal)
        submitButton.isEnabled = false

        let textfields: [UIControl] = [emailTextField, firstNameTextField, lastNameTextField, phoneNumberTextField]
        setupInputViews(textfields)
        observe(event: .editingChanged, of: textfields)
        
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
        let model = ContactRequestModel(
            firstName: firstNameTextField.text,
            lastName: lastNameTextField.text,
            email: emailTextField.text,
            phoneNumber: phoneNumberTextField.text,
            message: messageTextView.text
        )
        
        setLoadingViewVisibility(true)
        
        networkingService.request(endpoint: FormEndpoint.contact(model: model)) { [weak self] result in
            self?.handle(result: result)
        }
    }
}

extension ContactUsViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.highlightBorder()
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        textView.cancelHighlight()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        eventHasOccured()
    }
}

extension ContactUsViewController: ControlsObserving {
    func eventHasOccured() {
        let inputs: [UITextInput] = [emailTextField, firstNameTextField, lastNameTextField, phoneNumberTextField, messageTextView]
        submitButton.isEnabled = !inputs.contains(where: { !$0.hasText })
    }
}

extension ContactUsViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

extension ContactUsViewController {
    private func setTextfieldLabels() {
        titleLabel.text = "CONTACT_US_TITLE".localized
        firstNameLabel.text = "CONTACT_US_FIRST_NAME".localized
        lastNameLabel.text = "CONTACT_US_LAST_NAME".localized
        emailLabel.text = "CONTACT_US_EMAIL".localized
        phoneNumberLabel.text = "CONTACT_US_PHONE_NUMBER".localized
        messageLabel.text = "CONTACT_US_MESSAGE".localized
    }
    
    private func clearFields() {
        [emailTextField, firstNameTextField, lastNameTextField, phoneNumberTextField]
            .forEach { $0.text = nil }
        messageTextView.text = nil
    }
    
    private func handle(result: Result<ContactResponseModel?, Error>) {
        setLoadingViewVisibility(false)
        
        switch result {
        case let .success(response):
            switch response?.outcome {
            case .failure:
                displayErrorAlert(message: response?.reason ?? "CONTACT_US_SUBMIT_ERROR".localized)
            default:
                displayAlert(
                    title: "CONTACT_US_SUCCESS_ALERT_TITLE".localized,
                    message: "CONTACT_US_SUCCESS_ALERT_MESSAGE".localized
                )
                clearFields()
            }
        case let .failure(error):
            displayErrorAlert(message: error.localizedDescription)
        }
    }
}
