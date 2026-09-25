import Foundation

enum FormEndpoint: Endpoint {
    case contact(model: ContactRequestModel)
    case tryDemo(model: DemoRequestModel)
    
    var method: String {
        return "POST"
    }
    
    var url: URL {
        switch self {
        case .contact:
            return Constants.URLs.Endpoints.contactForm
        case .tryDemo(model: _):
            return Constants.URLs.Endpoints.demoForm
        }
    }
    
    var headers: [String: String] {
        switch self {
        case .tryDemo, .contact:
            return ["Content-Type": "application/json"]
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case let .contact(model):
            return [
                "email": model.email ?? "",
                "first_name": model.firstName ?? "",
                "last_name": model.lastName ?? "",
                "phone_1": model.phoneNumber ?? "",
                "comments": model.message ?? ""
            ]
        case let .tryDemo(model):
            return [
                "email": model.email ?? "",
                "first_name": model.firstName ?? "",
                "phone_1": model.phoneNumber ?? "",
                "trustedform_cert_url": Constants.URLs.Endpoints.certificate
                                            .appendingPathComponent("\(model.certificateID)")
                                            .absoluteString
            ]
        }
    }
}
