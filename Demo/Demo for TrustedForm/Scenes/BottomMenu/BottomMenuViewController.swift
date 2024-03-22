import UIKit
import SwiftUI
import TrustedFormSwift

// Define your SwiftUI view
struct SwiftUIExampleView: View {
    @State private var certificate: Certificate? = nil
    @State private var showError: Bool = false
    
    var body: some View {
        VStack {
            if let certificate = certificate {
                TrustedFormSwiftUIView(
                    certificate: certificate,
                    onFormSubmit: {
                        // Handle form submission
                        print("Form submitted")
                    },
                    customizations: TrustedFormViewCustomizations(
                        consentBackgroundColor: UIColor.white,
                        consentTextColor: UIColor.white,
                        consentBorderColor: UIColor.black,
                        submitButtonColor: UIColor.lightGray,
                        submitButtonDisabledColor: .darkGray,
                        submitButtonTitleColor: UIColor.red,
                        submitButtonTitle: "Submit & Continue",
                        submitButtonFont: .boldSystemFont(ofSize: 12),
                        submitButtonCornerRadius: 3,
                        submitButtonHeight: 100,
                        consentTextFont: .italicSystemFont(ofSize: 12),
                        isConsentBorderVisible: true,
                        consentTextPosition: .bottom
                    )
                )
                .frame(width: 300, height: 200)
            } else {
                Text("Loading certificate...")
            }
        }
        .onAppear {
            createCertificate()
        }
        .alert(isPresented: $showError) {
            Alert(
                title: Text("Error"),
                message: Text("Failed to create a certificate."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    private func createCertificate() {
        TrustedForm.default.createCertificate(consentText: "Your consent text here") { result in
            switch result {
            case .success(let cert):
                self.certificate = cert
            case .failure:
                self.showError = true
            }
        }
        
    }
}

// Enum for tab types
enum TabType {
    case home, tryDemo, contactUs, swiftUIExample
}

// Protocol for switching tabs
protocol TabBarSwitchable {
    func changeTab(_ tab: TabType)
}

// The BottomMenuViewController class
final class BottomMenuViewController: UITabBarController {
    private lazy var homeViewController: HomeViewController = UIStoryboard.instantiateInitialViewController()
    private lazy var contactUsViewController: ContactUsViewController = UIStoryboard.instantiateInitialViewController()
    
    private var tryDemoNavigationController: TrustedFormNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeNavigationController = TrustedFormNavigationController(rootViewController: homeViewController)
        homeNavigationController.tabBarItem = UITabBarItem(title: "BOTTOM_MENU_HOME".localized, image: #imageLiteral(resourceName: "home"), selectedImage: #imageLiteral(resourceName: "home"))
        
        let demoViewController: TryOurDemoViewController = UIStoryboard.instantiateInitialViewController()
        let tryDemoNavigationController = TrustedFormNavigationController(rootViewController: demoViewController)
        tryDemoNavigationController.tabBarItem = UITabBarItem(title: "BOTTOM_MENU_TRY_DEMO".localized, image: #imageLiteral(resourceName: "try-demo"), selectedImage: #imageLiteral(resourceName: "try-demo"))
        self.tryDemoNavigationController = tryDemoNavigationController
        
        let contactUsNavigationController = TrustedFormNavigationController(rootViewController: contactUsViewController)
        contactUsNavigationController.tabBarItem = UITabBarItem(title: "BOTTOM_MENU_CONTACT_US".localized, image: #imageLiteral(resourceName: "contact-us"), selectedImage: #imageLiteral(resourceName: "contact-us"))
        
        let swiftUIViewTab = createSwiftUIViewTab()
        
        setViewControllers([homeNavigationController, tryDemoNavigationController, contactUsNavigationController, swiftUIViewTab], animated: false)
        delegate = self
        tabBar.tintColor = #colorLiteral(red: 0.1817100644, green: 0.8225213885, blue: 0.5138735771, alpha: 1)
    }
    
    private func createSwiftUIViewTab() -> UIViewController {
        let swiftUIView = SwiftUIExampleView()
        let hostingController = UIHostingController(rootView: swiftUIView)
        hostingController.tabBarItem = UITabBarItem(title: "SwiftUI", image: UIImage(systemName: "swift"), selectedImage: UIImage(systemName: "swift.fill"))
        return hostingController
    }
    
    fileprivate func reloadDemoView() {
        let demoViewController: TryOurDemoViewController = UIStoryboard.instantiateInitialViewController()
        self.tryDemoNavigationController?.setViewControllers([demoViewController], animated: false)
    }
}

// UITabBarControllerDelegate conformance
extension BottomMenuViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController == self.tryDemoNavigationController {
            self.reloadDemoView()
        }
    }
}

// TabBarSwitchable protocol conformance
extension BottomMenuViewController: TabBarSwitchable {
    func changeTab(_ tab: TabType) {
        switch tab {
        case .home:
            selectedIndex = 0
        case .tryDemo:
            self.reloadDemoView()
            selectedIndex = 1
        case .contactUs:
            selectedIndex = 2
        case .swiftUIExample:
            selectedIndex = 3
        }
    }
}
