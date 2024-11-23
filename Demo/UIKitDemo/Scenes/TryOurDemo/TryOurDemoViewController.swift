import TrustedFormSwift
import UIKit

final class TryOurDemoViewController: UIViewController, FormInputsHighlightable, LoadingViewHandling {
    @IBOutlet private var formView: UIView!
    @IBOutlet private var fullNameTextField: UITextField!
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var phoneNumberTextField: UITextField!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var fullNameLabel: UILabel!
    @IBOutlet private var emailLabel: UILabel!
    @IBOutlet private var phoneNumberLabel: UILabel!
//    @IBOutlet private var trustedFormWidget: TrustedFormSwift.TrustedFormView!
    @IBOutlet private(set) var loadingView: UIView?
    
    private var certificate: Certificate?
    private var networkingService: NetworkingProtocol = NetworkingService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "TRY_OUR_DEMO_NAV_TITLE".localized
        titleLabel.text = "TRY_OUR_DEMO_TITLE".localized
        textLabel.textWithLineSpacing("TRY_OUR_DEMO_TEXT".localized, lineHeight: 21)
        fullNameLabel.text = "TRY_OUR_DEMO_FULL_NAME".localized
        emailLabel.text = "TRY_OUR_DEMO_EMAIL".localized
        phoneNumberLabel.text = "TRY_OUR_DEMO_PHONE_NUMBER".localized

        setupInputViews([emailTextField, fullNameTextField, phoneNumberTextField])
        
        emailTextField.isSensitive = true
        
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        phoneNumberTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        setLoadingViewVisibility(true, shouldAnimate: false)
        
        TrustedForm.default.createCertificate(consentText: "TRY_OUR_DEMO_CONSENT".localized) { [weak self] result in
            switch result {
            case let .success(certificate):
                self?.certificate = certificate
                self?.trustedFormWidget.initialize(with: certificate)
                self?.setLoadingViewVisibility(false)
                
                TrustedForm.default.startTracking(for: certificate)
            case .failure:
                self?.setLoadingViewVisibility(false)
                
                self?.emailTextField.isEnabled = false
                self?.fullNameTextField.isEnabled = false
                self?.phoneNumberTextField.isEnabled = false
                
                self?.displayErrorAlert(message: "TRY_OUR_DEMO_CERT_ERROR".localized)
            }
        }
        
        trustedFormWidget.delegate = self
        trustedFormWidget.isSubmitEnabled = false
    }
    
    private func handle(result: Result<DemoResponseModel?, Error>) {
        setLoadingViewVisibility(false)
        
        switch result {
        case let .success(response):
            switch response?.outcome {
            case .failure:
                displayErrorAlert(message: response?.reason ?? "TRY_OUR_DEMO_SUBMIT_ERROR".localized)
            default:
                navigateToSuccessScene()
                clearFields()
            }
        case let .failure(error):
            displayErrorAlert(message: error.localizedDescription)
        }
    }
    
    private func clearFields() {
        [emailTextField, fullNameTextField, phoneNumberTextField].forEach { $0.text = nil }
    }
    
    private func navigateToSuccessScene() {
        let viewController: DemoSuccessViewController = UIStoryboard.instantiateInitialViewController()
        navigationController?.pushViewController(viewController, animated: true)
        if let certificate = certificate {
            TrustedForm.default.stopTracking(for: certificate)
        }
    }
    
    @objc
    func textFieldDidChange(_ sender: UITextField) {
        trustedFormWidget.isSubmitEnabled =
            (fullNameTextField.text ?? "") != "" &&
            (emailTextField.text ?? "") != "" &&
            (phoneNumberTextField.text ?? "") != ""
    }

    @IBAction private func didTapAbout(_ sender: UIButton) {
        let viewController = AboutDialogViewController(nibName: nil, bundle: Bundle(for: type(of: self)))
        viewController.modalPresentationStyle = .overFullScreen
        viewController.modalTransitionStyle = .crossDissolve
        present(viewController, animated: true, completion: nil)
    }
}

extension TryOurDemoViewController: TrustedFormViewDelegate {
    func submitTapped(in trustedFormView: TrustedFormView) {
        guard let certificateId = certificate?.id else {
            return
        }
        
        let model = DemoRequestModel(
            firstName: fullNameTextField.text,
            email: emailTextField.text,
            phoneNumber: phoneNumberTextField.text,
            certificateID: certificateId
        )
        
        setLoadingViewVisibility(true)
        
        networkingService.request(endpoint: FormEndpoint.tryDemo(model: model)) { [weak self] result in
            self?.handle(result: result)
        }
    }
}
