//

import SwiftUI
import TrustedFormSwift

@main
struct SwiftUIDemoApp: App {
    init() {
        configureTrustedFormSDK()
    }

    var body: some Scene {
        WindowGroup {
            AppContent()
        }
    }
}

extension SwiftUIDemoApp {
    private func configureTrustedFormSDK() {

        if let trustedFormToken: String = try? BuildConfiguration.value(for: "TRUSTEDFORM_TOKEN") {
            TrustedForm.default.configure(
                appId: "sborrazas-prod",
                accessToken: trustedFormToken
            )
        }
    }
}
