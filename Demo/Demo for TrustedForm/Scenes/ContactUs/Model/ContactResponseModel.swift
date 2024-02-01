struct ContactResponseModel: Codable {
    let outcome: Outcome
    let reason: String?
    let lead: Lead
    let price: Int
}

extension ContactResponseModel {
    struct Lead: Codable {
        let id: String
    }
    
    enum Outcome: String, Codable {
        case success, failure
    }
}

