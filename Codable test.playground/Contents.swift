import Foundation

let jsonString = """
{
    "first_name": "John",
    "last_name": "Doe",
    "country": "United Kingdom"
}
"""

struct User: Codable {
    var firstName: String
    var lastName: String
    var country: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case country
    }
    
    static func performDecode(withJSONString jsonString: String) -> User? {
        
        guard let jsonData = jsonString.data(using: .utf8) else { return nil }
        
        do {
            let user = try JSONDecoder().decode(User.self, from: jsonData)
            return user
        }
        catch (let err) {
            print(err.localizedDescription)
            return nil
        }
    }
    
    static func perfromEncode(forUser user: User) -> String? {
        do {
            let jsonData = try JSONEncoder().encode(user)
            let jsonString = String(data: jsonData, encoding: .utf8)
            return jsonString
        }
        catch (let encodeErr) {
            print(encodeErr.localizedDescription)
            return nil
        }
    }
}

func performCodable () {
    let user = User.performDecode(withJSONString: jsonString)
    print(user?.firstName)
    
    var u = User(firstName: "Bob", lastName: "and Alice", country: "Cryptoland")
    let jsonString = User.perfromEncode(forUser: u)
    print(jsonString)
}

performCodable()
