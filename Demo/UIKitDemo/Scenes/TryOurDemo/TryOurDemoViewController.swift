import TrustedFormSwift
import UIKit

final class TryOurDemoViewController: UIViewController, FormInputsHighlightable, LoadingViewHandling {
    private let submissionId = "try-our-demo-screen"

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var textLabel: UILabel!

    @IBOutlet private var fullNameLabel: UILabel!
    @IBOutlet private var fullNameTextField: UITextField!

    @IBOutlet private var emailLabel: UILabel!
    @IBOutlet private var emailTextField: UITextField!

    @IBOutlet private var phoneNumberLabel: UILabel!
    @IBOutlet private var phoneNumberTextField: UITextField!

    @IBOutlet private var messageLabel: UILabel!
    @IBOutlet private var messageTextView: UITextView!

    @IBOutlet var isMilitaryIndicatorImage: UIImageView!
    @IBOutlet var isMilitaryLabel: UILabel!
    @IBOutlet var isMilitaryButton: UIButton!

    @IBOutlet var advertiserAIndicatorImage: UIImageView!
    @IBOutlet var advertiserALabel: UILabel!
    @IBOutlet var advertiserAButton: UIButton!

    @IBOutlet var advertiserBIndicatorImage: UIImageView!
    @IBOutlet var advertiserBLabel: UILabel!
    @IBOutlet var advertiserBButton: UIButton!

    @IBOutlet private(set) var loadingView: UIView?

    @IBOutlet var consentText: UILabel!

    @IBOutlet var submitButton: UIButton!

    private var certificate: Certificate?
    private var networkingService: NetworkingProtocol = NetworkingService()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureElementRoles()
        setLoadingViewVisibility(true, shouldAnimate: false)

        createCertificate()
        emailTextField.text = "asdf@email.com"
    }

    private func configureUI() {
        navigationItem.title = "TRY_OUR_DEMO_NAV_TITLE".localized

        titleLabel.text = "TRY_OUR_DEMO_TITLE".localized
        textLabel.textWithLineSpacing("TRY_OUR_DEMO_TEXT".localized, lineHeight: 21)

        fullNameLabel.text = "TRY_OUR_DEMO_FULL_NAME".localized
        emailLabel.text = "TRY_OUR_DEMO_EMAIL".localized
        phoneNumberLabel.text = "TRY_OUR_DEMO_PHONE_NUMBER".localized
        messageLabel.text = "CONTACT_US_MESSAGE".localized
        isMilitaryLabel.text = "TRY_OUR_DEMO_MILITARY".localized
        advertiserALabel.text = "Advertiser A"
        advertiserBLabel.text = "Advertiser B"

        isMilitaryIndicatorImage.setChecked(false)
        advertiserAIndicatorImage.setChecked(false)
        advertiserBIndicatorImage.setChecked(false)

        messageTextView.setupBorder()
        isMilitaryButton.configuration = .invisible()
        advertiserAButton.configuration = .invisible()
        advertiserBButton.configuration = .invisible()

        setupHighlighting([
            emailTextField,
            fullNameTextField,
            phoneNumberTextField
        ])

        // Mark email as sensitive
        emailTextField.isSensitive = true
    }

    private func configureElementRoles() {
        // Text fields
        fullNameTextField.tfElementRole = .consentTrackedText(
            submissionId: submissionId,
            label: "TRY_OUR_DEMO_FULL_NAME".localized
        )

        emailTextField.tfElementRole = .consentTrackedText(
            submissionId: submissionId,
            label: "TRY_OUR_DEMO_EMAIL".localized
        )

        phoneNumberTextField.tfElementRole = .consentTrackedText(
            submissionId: submissionId,
            label: "TRY_OUR_DEMO_PHONE_NUMBER".localized
        )

        messageTextView.tfElementRole = .consentTrackedText(
            submissionId: submissionId,
            label: "CONTACT_US_MESSAGE".localized
        )

        // Military toggle
        isMilitaryLabel.tfElementRole = .consentTrackedField(
            submissionId: submissionId,
            index: 0
        )
        isMilitaryButton.tfElementRole = .consentTrackedInput(
            submissionId: submissionId,
            label: "Military",
            index: 0
        )

        // Advertiser toggles
        advertiserALabel.tfElementRole = .consentOptedAdvertiserName(
            submissionId: submissionId,
            index: 0
        )
        advertiserAButton.tfElementRole = .consentOptedAdvertiserInput(
            submissionId: submissionId,
            label: "Advertiser A",
            index: 0
        )

        advertiserBLabel.tfElementRole = .consentOptedAdvertiserName(
            submissionId: submissionId,
            index: 1
        )
        advertiserBButton.tfElementRole = .consentOptedAdvertiserInput(
            submissionId: submissionId,
            label: "Advertiser B",
            index: 1
        )

        submitButton.tfElementRole = .submit(submissionId: submissionId, label: "Send Message")

        consentText.tfElementRole = .consentLanguage(submissionId: submissionId)
    }

    private func createCertificate() {
        Task {
            defer {
                self.setLoadingViewVisibility(false)
                // Add screenshot after loading view is hidden
                if let certificate = self.certificate {
                    do {
                        try TrustedForm.default.addScreenshot(to: certificate, delay: 0.2)
                    } catch {
                        print("Failed to take screenshot: \(error)")
                    }
                }
            }

            do {
                let certificate = try await TrustedForm.default.createCertificate()
                TrustedForm.default.startTracking(for: certificate)
                self.certificate = certificate
            } catch {
                self.emailTextField.isEnabled = false
                self.fullNameTextField.isEnabled = false
                self.phoneNumberTextField.isEnabled = false
                self.displayErrorAlert(message: "TRY_OUR_DEMO_CERT_ERROR".localized)
            }
        }
    }

    @IBAction func isMilitaryTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        isMilitaryIndicatorImage.setChecked(sender.isSelected)
    }

    @IBAction func advertiserATapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        advertiserAIndicatorImage.setChecked(sender.isSelected)
    }

    @IBAction func advertiserBTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        advertiserBIndicatorImage.setChecked(sender.isSelected)
    }

    @IBAction func submitTapped(_ sender: Any) {
        // Disable the submit button to prevent multiple taps
        submitButton.isEnabled = false

        // Add a delay of 0.5 seconds before pushing to the next screen
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }

            let viewController: AdvertiserSuggestionViewController = UIStoryboard.instantiateViewController()
            viewController.certificate = self.certificate
            self.navigationController?.pushViewController(viewController, animated: true)

            // Re-enable the submit button after navigation
            self.submitButton.isEnabled = true
        }
    }

    deinit {
        if let certificate = certificate {
            TrustedForm.default.stopTracking(for: certificate)
        }
    }
}

extension UIImageView {
    func setChecked(_ checked: Bool) {
        if checked {
            image = UIImage(systemName: "checkmark.square")
        } else {
            image = UIImage(systemName: "square")
        }
    }
}

public extension UIButton.Configuration {
    static func invisible() -> UIButton.Configuration {
        var style = UIButton.Configuration.plain()
        var background = UIButton.Configuration.plain().background
        background.backgroundColor = .clear
        style.background = background
        return style
    }
}

extension Bool {
    mutating func toggle() {
        if self == true {
            self = false
        } else {
            self = true
        }
    }
}

// extension TryOurDemoViewController: TrustedFormViewDelegate {
//    func submitTapped(in trustedFormView: TrustedFormView) {
//        guard let certificateId = certificate?.id else {
//            return
//        }
//
//        let model = DemoRequestModel(
//            firstName: fullNameTextField.text,
//            email: emailTextField.text,
//            phoneNumber: phoneNumberTextField.text,
//            certificateID: certificateId
//        )
//
//        setLoadingViewVisibility(true)
//
//        networkingService.request(endpoint: FormEndpoint.tryDemo(model: model)) { [weak self] result in
//            self?.handle(result: result)
//        }
//    }
// }
