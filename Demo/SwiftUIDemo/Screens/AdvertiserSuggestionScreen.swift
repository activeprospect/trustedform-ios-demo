//

import SwiftUI
import TrustedFormSwift

struct AdvertiserSuggestionScreen: View {
    let certificate: Certificate?

    private let consentText: String =
        """
        By selecting an advertiser, you agree to receive communications from them about their products and services. You understand these communications may be through phone calls, text messages, or emails, and you can opt-out at any time.
        """

    var body: some View {
        List {
            AdvertiserListItem(
                name: "Advertiser A",
                submissionId: submissionId(advertiser: "Advertiser A")
            )

            AdvertiserListItem(
                name: "Advertiser B",
                submissionId: submissionId(advertiser: "Advertiser B")
            )

            AdvertiserListItem(
                name: "Advertiser C",
                submissionId: submissionId(advertiser: "Advertiser C")
            )

            AdvertiserListItem(
                name: "Advertiser D",
                submissionId: submissionId(advertiser: "Advertiser D")
            )

            AdvertiserListItem(
                name: "Advertiser E",
                submissionId: submissionId(advertiser: "Advertiser E")
            )

            Text(consentText)
                .trustedFormRole(.consentLanguage(submissionId: "advertiser-suggestion-screen"), text: consentText)
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.vertical)

            Button(
                action: {
                    if let certificate {
                        TrustedForm.default.stopTracking(for: certificate)
                    }
                },
                label: {
                    Text("Stop Tracking")
                        .frame(maxWidth: .infinity)
                }
            )
            .padding()
        }
    }

    private func submissionId(advertiser: String) -> String {
        return "advertiser-suggestion-screen-\(advertiser)"
    }
}

#Preview {
    AdvertiserSuggestionScreen(
        certificate: nil
    )
}

private struct AdvertiserListItem: View {
    let name: String
    let submissionId: String
    @State var selected: Bool = false

    var body: some View {
        HStack {
            Text("\(name) can help you with this decision.")
                .trustedFormRole(.consentTrackedText(submissionId: submissionId, label: name),
                                 text: name)
            Spacer()
            Button(
                action: {
                    selected = true
                },
                label: {
                    if selected {
                        Image(systemName: "checkmark.square")
                    } else {
                        Text("Get Info")
                    }
                }
            )
            .trustedFormRole(
                .submit(
                    submissionId: submissionId,
                    label: "Get Info"
                ),
                title: "Get Info"
            )
            .buttonStyle(.bordered)
        }
    }
}
