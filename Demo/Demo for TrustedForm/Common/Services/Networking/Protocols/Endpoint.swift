import Foundation
import Alamofire

protocol Endpoint {
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders { get }
    var url: URL { get }
}

extension Endpoint {
    var queryItems: Parameters? { nil }
}
