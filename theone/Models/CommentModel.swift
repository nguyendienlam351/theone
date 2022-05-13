//
//  CommentModel.swift
//  theone
//
//  Created by nguyennam on 5/13/22.
//

import Foundation

struct CommentModel: Encodable, Decodable, Identifiable {
    var id = UUID()
    var profile: String
    var postId: String
    var username: String
    var date: Double
    var comment: String
    var ownerId: String
    
}
