import UIKit
import TrustedFormSwift

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        ViewControllerManager().setInitialViewController(window: window)

        TrustedForm.default.configure(
            appId: "com.activeprospect.trustedform.demo.dev",
            accessToken: "e21e11c1743fb512d85b600887d2162bee3ced7b")
        
        return true
    }
}
