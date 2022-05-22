//
//  MessageModel.swift
//  theone
//
//  Created by lequy on 5/16/22.
//

import Foundation

struct MessageModel: Encodable, Decodable, Identifiable {
    // MARK: Properties
    var id = UUID()
    var lastMessage: String
    var username: String
    var isPhoto: Bool
    var timestamp: Double
    var userId: String
    var profile: String
}
