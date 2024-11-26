import enum Alamofire.AFError

protocol NetworkingProtocol {
    func request<T: Codable>(endpoint: Endpoint,
                            handler: @escaping (Result<T?, Error>) -> Void)
}
