import UIKit

final class ViewControllerManager {
    func setInitialViewController(window: UIWindow? = nil) {
        let activeProspectViewController: WhoIsActiveProspectViewController = UIStoryboard.instantiateViewController()
        
        let rootViewController = UserDefaults.hasSeenIntro
            ? BottomMenuViewController()
            : TrustedFormNavigationController(rootViewController: activeProspectViewController)
        
        setInitial(viewController: rootViewController, window: window)
    }

    func setInitial(viewController: UIViewController, window: UIWindow? = nil) {
        let window = window ?? getWindow()
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }

    private func getWindow() -> UIWindow {
        if let window = UIApplication.shared.keyWindow {
            return window
        }
        return UIWindow(frame: UIScreen.main.bounds)
    }
}

extension UIStoryboard {
    static func instantiateViewController<Controller: UIViewController>(name: String? = nil, bundle: Bundle = Bundle.main) -> Controller {
        let controllerName = name ?? String(describing: Controller.self)
        let storyboard = UIStoryboard(name: controllerName, bundle: bundle)
        guard let controller = storyboard.instantiateInitialViewController() as? Controller else {
            fatalError("Couldn't instantiate \(controllerName)")
        }
        return controller
    }
}
