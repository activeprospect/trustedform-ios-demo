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
    @IBOutlet private weak var trustedFormWidget: TrustedFormView!
    @IBOutlet private weak var loadingView: UIView!
    
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
        
        emailTextField.isSensitive = true
        
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        phoneNumberTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        loadingView.isHidden = false
        
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
                
                TrustedForm.default.startTracking(for: certificate)
            case .failure(_):
                break
            }
        }
        
        trustedFormWidget.delegate = self
        trustedFormWidget.isSubmitEnabled = false
    }
    
    @objc
    func textFieldDidChange(_ sender: UITextField) {
        trustedFormWidget.isSubmitEnabled =
            (fullNameTextField.text ?? "") != "" &&
            (emailTextField.text ?? "") != "" &&
            (phoneNumberTextField.text ?? "") != ""
    }
}

extension TryOurDemoViewController: TrustedFormViewDelegate {
    func submitTapped(in trustedFormView: TrustedFormView) {
        guard let certificateId = certificate?.id else {
            return
        }
        let queryItems = [
            URLQueryItem(name: "email", value: emailTextField.text),
            URLQueryItem(name: "first_name", value: fullNameTextField.text),
            URLQueryItem(name: "phone", value: phoneNumberTextField.text),
            URLQueryItem(name: "xxTrustedFormCertUrl", value: "https://cert.staging.trustedform.com/\(certificateId)")]
        guard var urlComponents = URLComponents(string: "https://engage.activeprospect.com/l/801073/2021-04-09/7kj3l") else {
            return
        }
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else {
            return
        }
        
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request as URLRequest, completionHandler: { [weak self] _, _, error in
            DispatchQueue.main.async {
                self?.handleSubmitResponse(error: error)
            }
        })
        
        self.loadingView.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            self.loadingView.alpha = 1
        })
        task.resume()
    }
    
    private func handleSubmitResponse(error: Error?) {
        UIView.animate(withDuration: 0.3, animations: {
            self.loadingView.alpha = 0
        }) { _ in
            self.loadingView.isHidden = true
        }
        
        guard error == nil else {
            let alert = UIAlertController(
                title: nil,
                message: "TRY_OUR_DEMO_SUBMIT_ERROR".localized,
                preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
            
            return
        }
        
        let viewController: DemoSuccessViewController = UIStoryboard.instantiateInitialViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
        if let certificate = self.certificate {
            TrustedForm.default.stopTracking(for: certificate)
        }
    }
}
