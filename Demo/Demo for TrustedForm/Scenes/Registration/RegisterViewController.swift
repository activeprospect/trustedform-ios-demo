import UIKit

final class RegisterViewController: UIViewController, FormInputsHighlightable {
    @IBOutlet private var formView: UIView!
    @IBOutlet private var registerButton: UIButton!
    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var fullNameLabel: UILabel!
    @IBOutlet private var emailLabel: UILabel!
    @IBOutlet private var passwordLabel: UILabel!
    @IBOutlet private var loginLabel: UILabel!
    @IBOutlet private var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        emailLabel.text = "SIGN_UP_EMAIL".localized
        passwordLabel.text = "SIGN_UP_PASSWORD".localized
        loginButton.setTitle("SIGN_UP_BUTTON".localized, for: .normal)
        loginLabel.text = "SIGN_UP_LOGIN_LABEL".localized
        loginButton.setTitle("SIGN_UP_LOGIN_BUTTON".localized, for: .normal)
        textLabel.textWithLineSpacing("SIGN_UP_TEXT".localized, lineHeight: 21)
        titleLabel.text = "SIGN_UP_TITLE".localized
        navigationItem.title = "SIGN_UP_NAV_TITLE".localized

        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "SIGN_UP_SKIP".localized, style: .plain, target: self, action: #selector(skip))
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.1764705882, green: 0.8, blue: 0.4392156863, alpha: 1)
        registerButton.layer.masksToBounds = true
        setupInputViews([nameTextField, emailTextField, passwordTextField])
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        registerButton.layer.cornerRadius = 4
    }

    @objc private func skip() {
        goBackToHome()
    }

    @IBAction private func register(_ sender: UIButton) {
        goBackToHome()
    }

    @IBAction private func login() {
        navigationController?.popViewController(animated: true)
    }

    private func goBackToHome() {
        guard let tabBarController = tabBarController as? TabBarSwitchable else {
            return
        }
        tabBarController.changeTab(.home)
    }
}
