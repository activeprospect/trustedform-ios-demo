import Foundation
import Alamofire

enum FormEndpoint: Endpoint {
    case contact(model: ContactRequestModel)
    case tryDemo(model: DemoRequestModel)
    
    var method: HTTPMethod {
        return .post
    }
    
    var url: URL {
        switch self {
        case .contact:
            return Constants.URLs.Endpoints.contactForm
        case .tryDemo(model: _):
            return Constants.URLs.Endpoints.demoForm
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .tryDemo, .contact:
            return [.contentType("application/json")]
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .tryDemo, .contact:
            return JSONEncoding.default
        }
    }
    
    var parameters: Parameters? {
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
