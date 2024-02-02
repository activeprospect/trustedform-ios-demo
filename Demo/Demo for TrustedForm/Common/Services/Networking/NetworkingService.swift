import Foundation
import Alamofire

struct NetworkingService {
    private let session: Session
    
    init(session: Session = .init()) {
        self.session = session
    }
}

extension NetworkingService: NetworkingProtocol {
    func request<T: Codable>(endpoint: Endpoint, handler: @escaping (Result<T?, Error>) -> Void) {
        session.request(
            endpoint.url,
            method: endpoint.method,
            parameters: endpoint.parameters,
            encoding: endpoint.encoding,
            headers: endpoint.headers)
        .validate()
        .responseData { response in
            handler(
                response.result
                    .mapError { NetworkingError.custom(message: $0.localizedDescription) }
                    .map { try? JSONDecoder().decode(T.self, from: $0) }
            )
        }
    }
}
