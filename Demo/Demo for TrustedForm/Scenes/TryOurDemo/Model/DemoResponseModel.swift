struct DemoResponseModel: Codable {
    let outcome: Outcome
    let reason: String?
    let lead: Lead
    let price: Int
}

extension DemoResponseModel {
    struct Lead: Codable {
        let id: String
    }
    
    enum Outcome: String, Codable {
        case success, failure
    }
}
