//
//  Extensions.swift
//  theone
//
//  Created by nguyenlam on 4/30/22.
//

import Foundation

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionaty = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        else {
            throw NSError()
        }
        
        return dictionaty
    }
}


extension Decodable {
    init(fromDictionary: Any) throws {
        let data = try JSONSerialization.data(withJSONObject: fromDictionary, options: .prettyPrinted)
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: data)
    }
}


extension String {
    func splitsString() -> [String] {
        var stringArray: [String] = []
        let trimmed = String(self.filter {!" \n\t\r".contains($0)})
        
        for (index, _) in trimmed.enumerated() {
            let prefixIndex = index + 1
            let substringPrefix = String(trimmed.prefix(prefixIndex)).lowercased()
            stringArray.append(substringPrefix)
        }
        
        return stringArray
    }
}
