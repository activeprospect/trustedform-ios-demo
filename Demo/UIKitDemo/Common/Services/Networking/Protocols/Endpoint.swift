import Foundation

protocol Endpoint {
    var method: String { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String] { get }
    var url: URL { get }
}
