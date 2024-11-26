import UIKit

final class TrustedFormNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        interactivePopGestureRecognizer?.delegate = nil
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override var navigationBar: UINavigationBar {
        let customNavigationBar = super.navigationBar
        customNavigationBar.tintColor = .white
        customNavigationBar.barTintColor = #colorLiteral(red: 0.1490000039, green: 0.2080000043, blue: 0.2820000052, alpha: 1)
        customNavigationBar.barStyle = .blackOpaque
        customNavigationBar.backgroundColor = #colorLiteral(red: 0.1490000039, green: 0.2080000043, blue: 0.2820000052, alpha: 1)
        return customNavigationBar
    }
}
