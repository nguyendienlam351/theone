//
//  Extensions.swift
//  theone
//
//  Created by nguyenlam on 4/30/22.
//

import SwiftUI

// MARK: View
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
    
    func navigationBarColor(backgroundColor: UIColor?, titleColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: titleColor))
    }

}

// MARK: Encodable
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


// MARK: Decodable
extension Decodable {
    init(fromDictionary: Any) throws {
        let data = try JSONSerialization.data(withJSONObject: fromDictionary, options: .prettyPrinted)
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: data)
    }
}

// MARK: String
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
    
    func removeWhiteSpace() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}

// MARK: Date
extension Date {
    func timeAgo() -> String {
        let formater = DateComponentsFormatter()
        formater.unitsStyle = .full
        formater.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        formater.zeroFormattingBehavior = .dropAll
        formater.maximumUnitCount = 1
        return String(format: formater.string(from: self, to: Date()) ?? "", locale: .current)
    }
}

// MARK: UIColor
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    static let primary = UIColor(hexString: "E85626")
    static let secondary = UIColor(hexString: "AF2D23")
    static let thirdly = UIColor(hexString: "606060")
    static let backgroundColor = UIColor.black
}

// MARK: Color
extension Color {
    static let primary = Color(UIColor(hexString: "E85626"))
    static let secondary = Color(UIColor(hexString: "AF2D23"))
    static let thirdly = Color(UIColor(hexString: "606060"))
    static let backgroundColor = Color(UIColor.black)
}
