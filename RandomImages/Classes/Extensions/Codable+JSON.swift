
import Foundation

extension Encodable {
	
	func encoded() throws -> Data {
		return try JSONEncoder().encode(self)
	}
	
	func encodeToDictionary() throws -> [String: Any] {
		if let dictionary = try JSONSerialization.jsonObject(with: self.encoded(), options: .allowFragments) as? [String: Any] {
			return dictionary
		}
		
		return [String: Any]()
	}
	
}

extension Data {
	
	func decoded<T: Decodable>() throws -> T {
		return try JSONDecoder().decode(T.self, from: self)
	}
	
}
