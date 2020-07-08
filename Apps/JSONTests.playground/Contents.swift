import Foundation

//enum CodingError: Error {
//    case decodingError(String)
//}

//enum Currency: String, Codable {
//    enum CodingKeys: String, CodingKey {
//        case GBP = "GBP"
//        case USD = "USD"
//        case CAD = "CAD"
//    }
//    // TODO: Add coding keys
//    case GBP = "£"
//    case USD = "$"
//    case CAD = "C$"
//
//    func encode(to encoder: Encoder) throws {
//        var values = encoder.container(keyedBy: CodingKeys.self)
//        print(values)
//        switch self {
//        case .GBP:
//            try values.encode(CodingKeys.GBP.rawValue, forKey: .GBP)
//        case .USD:
//            try values.encode(CodingKeys.USD.rawValue, forKey: .USD)
//        case .CAD:
//            try values.encode(CodingKeys.CAD.rawValue, forKey: .CAD)
//        }
//    }
//
//    init(from decoder: Decoder) throws {
//
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        print(values)
//        print("HEre")
//
//        if let _ = try? values.decode(Currency.self, forKey: .GBP) {
//            self = .GBP
//        } else if let _ = try? values.decode(Currency.self, forKey: .USD) {
//            self = .USD
//        } else if let _ = try? values.decode(Currency.self, forKey: .CAD) {
//            self = .CAD
//        } else {
//            print("************** NEED TO THROW ERROR **************")
//            throw CodingError.decodingError("some messasge")
//        }
//
//    }
////    func encode(to encoder: Encoder) throws {
////        var container = encoder.container(keyedBy: CodingKeys.self)
////        switch self {
////        case .GBP:
////            try container.encode(CodingKeys.GBP.rawValue, forKey: .GBP)
////        case .USD:
////            try container.encode(CodingKeys.USD.rawValue, forKey: .USD)
////        case .CAD:
////            try container.encode(CodingKeys.CAD.rawValue, forKey: .CAD)
////        }
////    }
//}

enum Currency: String, Codable {
    // TODO: Add coding keys
    case GBP = "GBP"
    case USD = "USD"
    case CAD = "CAD"

    static func stringSymbol(of currency: Currency) -> String {
        switch currency {
        case .GBP:
            return "£"
        case .USD:
            return "$"
        case .CAD:
            return "C$"
        }
    }
}

struct Response: Codable {

    var currency: Currency?
    var id: String?

}

let jsonString = "{\"currency\": \"CAD\", \"id\": \"ijndsfg\"}"
//let jsonString = "{\"id\": \"ijndsfg\"}"


let data = jsonString.data(using: .utf8)

var response: Response?

do {
    response = try JSONDecoder().decode(Response.self, from: data!)
} catch let jsonErr {
    print(jsonErr)
}

print(response)
print(response?.id)
print(response?.currency?.rawValue)
