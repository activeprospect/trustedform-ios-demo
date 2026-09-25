import Foundation

struct NetworkingService {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension NetworkingService: NetworkingProtocol {
    func request<T: Codable>(endpoint: Endpoint, handler: @escaping (Result<T?, Error>) -> Void) {
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = endpoint.method
        endpoint.headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        if let parameters = endpoint.parameters {
            guard JSONSerialization.isValidJSONObject(parameters),
                  let body = try? JSONSerialization.data(withJSONObject: parameters) else {
                return handler(.failure(NetworkingError.custom(message: "Invalid request parameters")))
            }
            request.httpBody = body
        }

        session.dataTask(with: request) { data, response, error in
            let result: Result<T?, Error>
            if let error = error {
                result = .failure(NetworkingError.custom(message: error.localizedDescription))
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode, !(200..<300).contains(statusCode) {
                result = .failure(NetworkingError.custom(message: HTTPURLResponse.localizedString(forStatusCode: statusCode)))
            } else if let data = data, !data.isEmpty {
                result = .success(try? JSONDecoder().decode(T.self, from: data))
            } else {
                result = .failure(NetworkingError.unknown)
            }
            DispatchQueue.main.async { handler(result) }
        }.resume()
    }
}
