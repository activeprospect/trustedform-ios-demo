import UIKit

final class WhoIsActiveProspectViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var continueButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "WHO_IS_AP_NAV_TITLE".localized
        navigationItem.hidesBackButton = true
        titleLabel.text = "WHO_IS_AP_TITLE".localized
        textLabel.textWithLineSpacing("WHO_IS_AP_TEXT".localized, lineHeight: 21)
        continueButton.setTitle("WHO_IS_AP_CONTINUE_BUTTON".localized, for: .normal)

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "WHO_IS_AP_SKIP".localized, style: .plain, target: self, action: #selector(skip))
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.1764705882, green: 0.8, blue: 0.4392156863, alpha: 1)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        continueButton.layer.cornerRadius = 4
    }

    @objc private func skip() {
        let viewController = BottomMenuViewController()
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true) {
            UserDefaults.hasSeenIntro = true
        }
    }

    @IBAction private func `continue`() {
        let viewController: ExplainerViewController = UIStoryboard.instantiateInitialViewController()
        navigationController?.pushViewController(viewController, animated: true)
        UserDefaults.hasSeenIntro = true
    }
}
