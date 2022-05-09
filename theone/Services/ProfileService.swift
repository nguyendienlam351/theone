//
//  ProfileService.swift
//  theone
//
//  Created by lephuoc on 5/8/22.
//

import Foundation

class ProfileService: ObservableObject {
    @Published var posts: [PostModel] = []
    
    func loadUserPost(userId: String) {
        
        PostService.loadUserPost(userId: userId) {
            (posts) in
            self.posts = posts
        }
    }
}
