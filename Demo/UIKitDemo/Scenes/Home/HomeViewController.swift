import UIKit

final class HomeViewController: UIViewController {
    @IBOutlet private var tryDemoView: UIView!
    @IBOutlet private var topTitleLabel: UILabel!
    @IBOutlet private var topSubtitleLabel: UILabel!
    @IBOutlet private var tryDemoLabel: UILabel!

    @IBOutlet private var learnMoreView: UIView!
    @IBOutlet private var learnMoreLabel: UILabel!
    @IBOutlet private var learnMoreTitleLabel: UILabel!
    @IBOutlet private var learnMoreSubtitleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "HOME_NAV_TITLE".localized
        topTitleLabel.textWithLineSpacing("HOME_TILE_TITLE".localized, lineHeight: 26)
        topSubtitleLabel.textWithLineSpacing("HOME_TILE_TEXT".localized, lineHeight: 14)
        tryDemoLabel.text = "HOME_TILE_TRY_DEMO".localized
        learnMoreLabel.text = "HOME_LEARN_MORE_HEADER".localized
        learnMoreTitleLabel.text = "HOME_LEARN_MORE_TITLE".localized
        learnMoreSubtitleLabel.text = "HOME_LEARN_MORE_SUBTITLE".localized

        tryDemoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tryDemoTapped)))
        learnMoreView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(learnMoreTapped)))
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tryDemoView.superview?.layer.applyShadow(cornerRadius: 8)
        tryDemoView.layer.cornerRadius = 8

        learnMoreView.superview?.layer.applyShadow(cornerRadius: 8)
        learnMoreView.layer.cornerRadius = 8
    }

    @objc private func learnMoreTapped() {
        if let url = URL(string: "http://activeprospect.com") {
            UIApplication.shared.open(url)
        }
    }

    @objc private func tryDemoTapped() {
        guard let tabBarController = tabBarController as? TabBarSwitchable else {
            return
        }
        tabBarController.changeTab(.tryDemo)
    }
}
