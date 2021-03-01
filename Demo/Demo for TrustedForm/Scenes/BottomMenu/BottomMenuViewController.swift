import UIKit

enum TabType {
    case home, tryDemo, contactUs
}

protocol TabBarSwitchable {
    func changeTab(_ tab: TabType)
}

final class BottomMenuViewController: UITabBarController {
    private lazy var homeViewController: HomeViewController = UIStoryboard.instantiateInitialViewController()
    private lazy var tryOurDemoController: TryOurDemoViewController = UIStoryboard.instantiateInitialViewController()
    private lazy var contactUsViewController: ContactUsViewController = UIStoryboard.instantiateInitialViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeNavigationController = TrustedFormNavigationController(rootViewController: homeViewController)
        homeNavigationController.tabBarItem = UITabBarItem(title: "BOTTOM_MENU_HOME".localized, image: #imageLiteral(resourceName: "home"), selectedImage: #imageLiteral(resourceName: "home"))
        let tryDemoNavigationController = TrustedFormNavigationController(rootViewController: tryOurDemoController)
        tryDemoNavigationController.tabBarItem = UITabBarItem(title: "BOTTOM_MENU_TRY_DEMO".localized, image: #imageLiteral(resourceName: "try-demo"), selectedImage: #imageLiteral(resourceName: "try-demo"))
        let contactUsNavigationController = TrustedFormNavigationController(rootViewController: contactUsViewController)
        contactUsNavigationController.tabBarItem = UITabBarItem(title: "BOTTOM_MENU_CONTACT_US".localized, image: #imageLiteral(resourceName: "contact-us"), selectedImage: #imageLiteral(resourceName: "contact-us"))

        setViewControllers([homeNavigationController, tryDemoNavigationController, contactUsNavigationController], animated: false)
        delegate = self
        tabBar.tintColor = #colorLiteral(red: 0.1817100644, green: 0.8225213885, blue: 0.5138735771, alpha: 1)
    }
}

extension BottomMenuViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        (viewController as? UINavigationController)?.popToRootViewController(animated: false)
    }
}

extension BottomMenuViewController: TabBarSwitchable {
    func changeTab(_ tab: TabType) {
        switch tab {
        case .home:
            selectedIndex = 0
        case .tryDemo:
            selectedIndex = 1
        case .contactUs:
            selectedIndex = 2
        }
    }
}
