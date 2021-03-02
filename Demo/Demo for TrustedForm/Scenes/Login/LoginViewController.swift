import UIKit

final class LoginViewController: UIViewController, FormInputsHighlightable {
    @IBOutlet private var formView: UIView!
    @IBOutlet private var loginButton: UIButton!
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var emailLabel: UILabel!
    @IBOutlet private var passwordLabel: UILabel!
    @IBOutlet private var forgotPasswordButton: UIButton!
    @IBOutlet private var registerLabel: UILabel!
    @IBOutlet private var registerButton: UIButton!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var textLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        emailLabel.text = "SIGN_IN_EMAIL".localized
        passwordLabel.text = "SIGN_IN_PASSWORD".localized
        forgotPasswordButton.setTitle("SIGN_IN_FORGOT_PASSWORD".localized, for: .normal)
        loginButton.setTitle("SIGN_IN_BUTTON".localized, for: .normal)
        registerLabel.text = "SIGN_IN_REGISTER_LABEL".localized
        registerButton.setTitle("SIGN_IN_REGISTER_BUTTON".localized, for: .normal)
        textLabel.textWithLineSpacing("SIGN_IN_TEXT".localized, lineHeight: 21)
        titleLabel.text = "SIGN_IN_TITLE".localized
        navigationItem.title = "SIGN_IN_NAV_TITLE".localized

        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "SIGN_IN_SKIP".localized, style: .plain, target: self, action: #selector(skip))
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.1764705882, green: 0.8, blue: 0.4392156863, alpha: 1)
        loginButton.layer.masksToBounds = true
        setupInputViews([emailTextField, passwordTextField])
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        loginButton.layer.cornerRadius = 4
    }

    @objc private func skip() {
        goBackToHome()
    }

    @IBAction private func login(_ sender: UIButton) {
        goBackToHome()
    }

    @IBAction private func register() {
        let viewController: RegisterViewController = UIStoryboard.instantiateInitialViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func goBackToHome() {
        guard let tabBarController = tabBarController as? TabBarSwitchable else {
            return
        }
        tabBarController.changeTab(.home)
    }
}
