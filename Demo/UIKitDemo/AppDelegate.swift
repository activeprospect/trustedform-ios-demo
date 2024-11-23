import IQKeyboardManagerSwift
import TrustedFormSwift
import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        IQKeyboardManager.shared.enable = true

        window = UIWindow(frame: UIScreen.main.bounds)
        ViewControllerManager().setInitialViewController(window: window)

        let trustedFormToken: String = try! BuildConfiguration.value(for: "TRUSTEDFORM_TOKEN")

        TrustedForm.default.configure(
            appId: "sborrazas-prod",
            accessToken: trustedFormToken)

        return true
    }
}
