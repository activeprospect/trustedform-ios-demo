import SwiftUI
import TrustedFormSwift

extension Bool {
    var visibility: Visibility {
        if self == true {
            return .visible
        }
        return .hidden
    }
}

struct ContactInfoScreen: View {
    private let submissionId: String = "contact-info-screen"
    @Binding var path: NavigationPath
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var message: String = ""
    @State private var isMilitary: Bool = false
    @State private var advertiserOneConsent: Bool = false
    @State private var advertiserTwoConsent: Bool = false

    @State private var certificate: Certificate? = nil

    @State private var displayCertificateError: Bool = false
    @State private var certificateError: Error? = nil {
        didSet {
            if certificateError != nil {
                displayCertificateError = true
            }
        }
    }

    @State private var isLoading: Bool = false

    private let consentText: String =
        """
        This is some example consent text lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
        """

    private let isMilitaryText: String = "Did you or your spouse serve in the US military?"

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                Text("Your info will go to an agent who can answer your questions")
                VStack(alignment: .leading) {
                    TextField("Name", text: $firstName)
                        .trustedFormRole(
                            .consentTrackedText(
                                submissionId: submissionId,
                                label: "Name"
                            ),
                            binding: $firstName
                        )
                        .sensitive()
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("Email Address", text: $email)
                        .trustedFormRole(
                            .consentTrackedText(
                                submissionId: submissionId,
                                label: "Email Address"
                            ),
                            binding: $email
                        )
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("Phone Number", text: $phone)
                        .trustedFormRole(
                            .consentTrackedText(
                                submissionId: submissionId,
                                label: "Phone Number"
                            ),
                            binding: $phone
                        )
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("Message", text: $message, axis: .vertical)
                        .trustedFormRole(
                            .consentTrackedText(
                                submissionId: submissionId,
                                label: "Message"
                            ),
                            binding: $message
                        )
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                Toggle(isOn: $isMilitary) {
                    Text(isMilitaryText)
                        .trustedFormRole(
                            .consentTrackedField(
                                submissionId: submissionId,
                                index: 0
                            )
                        )
                        .multilineTextAlignment(.leading)
                        .font(.footnote)
                }
                .trustedFormRole(
                    .consentTrackedInput(
                        submissionId: submissionId,
                        label: "Military",
                        index: 0
                    ),
                    binding: $isMilitary
                )
                .toggleStyle(CheckboxToggleStyle())

                Button(
                    action: {
                        path.append(NavigationScreen.advertiserSelection)
                    },
                    label: {
                        Text("Send message")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                    }
                )
                .trustedFormRole(
                    .submit(
                        submissionId: submissionId,
                        label: "Submit"
                    ),
                    title: "Send message"
                )
                .buttonStyle(.borderedProminent)
                .tint(.black)

                Text(consentText)
                    .font(.footnote)
                    .trustedFormRole(.consentLanguage(submissionId: submissionId), text: consentText)

                VStack(
                    alignment: .leading,
                    content: {
                        Toggle(isOn: $advertiserOneConsent) {
                            Text("Advertiser 1")
                        }
                        .trustedFormRole(
                            .consentOptedAdvertiserInput(
                                submissionId: submissionId,
                                label: "Advertiser 1"
                            ),
                            binding: $advertiserOneConsent
                        )
                        .toggleStyle(CheckboxToggleStyle())

                        Toggle(isOn: $advertiserTwoConsent) {
                            Text("Advertiser 2")
                        }
                        .trustedFormRole(
                            .consentOptedAdvertiserInput(
                                submissionId: submissionId,
                                label: "Advertiser 2"
                            ),
                            binding: $advertiserTwoConsent
                        )
                        .toggleStyle(CheckboxToggleStyle())
                    }
                )
            }
            .padding()
        }
        .navigationDestination(for: NavigationScreen.self) { screen in
            switch screen {
            case .advertiserSelection:
                AdvertiserSuggestionScreen(
                    certificate: certificate
                )
            }
        }
        .toolbar {
            ToolbarItem(
                placement: .bottomBar,
                content: {
                    HStack(spacing: 4) {
                        Text("fetching certificate")
                        ProgressView()
                    }
                }
            )
        }
        .toolbar(isLoading.visibility, for: .bottomBar)
        .onAppear {
            Task {
                if certificate == nil {
                    await createCertificate()
                    if let certificate {
                        TrustedForm.default.startTracking(for: certificate)
                    }
                }
            }
        }
        .alert(isPresented: $displayCertificateError, content: {
            Alert(title: Text("An error occured while trying to create certificate."))
        })
        .disabled(certificateError != nil)
    }

    private func createCertificate() async {
        defer {
            isLoading = false
        }

        isLoading = true

        do {
            certificate = try await TrustedForm.default.createCertificate()
        } catch {
            certificateError = error
        }
    }
}

#Preview {
    NavigationStack {
        ContactInfoScreen(
            path: .constant(NavigationPath())
        )
        .navigationTitle("Contact for more info")
    }
}
