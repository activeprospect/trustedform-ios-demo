import UIKit
import IQKeyboardManagerSwift
import TrustedForm

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        IQKeyboardManager.shared.enable = true

        window = UIWindow(frame: UIScreen.main.bounds)
        ViewControllerManager().setInitialViewController(window: window)

        TrustedForm.default.configure(appId: "243c06e3-03a1-4d3f-a5c0-33715a428b85")
        
        return true
    }
}
