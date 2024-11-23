//

import SwiftUI

enum NavigationScreen {
    case advertiserSelection
}

struct AppContent: View {
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            ContactInfoScreen(path: $path)
                .navigationTitle("Contact for more info")
        }
    }
}

#Preview {
    AppContent()
}
