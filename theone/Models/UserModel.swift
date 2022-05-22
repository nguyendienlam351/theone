//
//  UserModel.swift
//  theone
//
//  Created by nguyenlam on 4/30/22.
//

import Foundation

struct User: Encodable, Decodable {
    // MARK: Properties
    var uid: String
    var email: String
    var profileImageUrl: String
    var username: String
    var bio: String
}
