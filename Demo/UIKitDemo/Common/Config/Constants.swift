import struct Foundation.URL

enum Constants {
    static let emailAddress = "support@activeprospect.com"
    
    enum URLs {
        static let website = URL(string: "https://activeprospect.com")!
        static let privacyPolicy = URL(string: "https://activeprospect.com/privacy-policy/")!
        
        enum Endpoints {
            static let contactForm = URL(string: "https://" + (try! BuildConfiguration.value(for: "CONTACT_URL")))!
            
            static let certificate = URL(string: "https://" + (try! BuildConfiguration.value(for: "CERTIFICATE_URL")))!

            static let demoForm = URL(string: "https://" + (try! BuildConfiguration.value(for: "DEMO_URL")))!
        }
    }
}
