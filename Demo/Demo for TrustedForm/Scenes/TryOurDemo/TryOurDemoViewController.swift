import UIKit
import TrustedForm

final class TryOurDemoViewController: UIViewController, FormInputsHighlightable {
    
    @IBOutlet private var formView: UIView!
    @IBOutlet private var fullNameTextField: UITextField!
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var phoneNumberTextField: UITextField!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var fullNameLabel: UILabel!
    @IBOutlet private var emailLabel: UILabel!
    @IBOutlet private var phoneNumberLabel: UILabel!
    @IBOutlet weak var trustedFormWidget: TrustedFormView!
    @IBOutlet weak var loadingView: UIView!
    
    private var certificate: Certificate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "TRY_OUR_DEMO_NAV_TITLE".localized
        titleLabel.text = "TRY_OUR_DEMO_TITLE".localized
        textLabel.textWithLineSpacing("TRY_OUR_DEMO_TEXT".localized, lineHeight: 21)
        fullNameLabel.text = "TRY_OUR_DEMO_FULL_NAME".localized
        emailLabel.text = "TRY_OUR_DEMO_EMAIL".localized
        phoneNumberLabel.text = "TRY_OUR_DEMO_PHONE_NUMBER".localized

        setupInputViews([emailTextField, fullNameTextField, phoneNumberTextField])
        emailTextField.delegate = self
        emailTextField.isSensitive = true
        
        TrustedForm.default.createCertificate(consentText: "TRY_OUR_DEMO_CONSENT".localized) { [weak self] (result) in
            switch result {
            case let .success(certificate):
                self?.certificate = certificate
                self?.trustedFormWidget.initialize(with: certificate)
                UIView.animate(withDuration: 0.3, animations: {
                    self?.loadingView.alpha = 0
                }) { _ in
                    self?.loadingView.isHidden = true
                }
            case .failure(_):
                break
            }
        }
        
        trustedFormWidget.delegate = self
    }
}

extension TryOurDemoViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let certificate = certificate {
            try? TrustedForm.default.addScreenshot(to: certificate)
        }
    }
}

extension TryOurDemoViewController: TrustedFormViewDelegate {
    func submitTapped(in trustedFormView: TrustedFormView) {
        let viewController: DemoSuccessViewController = UIStoryboard.instantiateInitialViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
