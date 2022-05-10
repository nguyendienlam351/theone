//
//  ProfileService.swift
//  theone
//
//  Created by lephuoc on 5/8/22.
//

import Foundation
import Firebase

class ProfileService: ObservableObject {
    @Published var posts: [PostModel] = []
    @Published var following = 0
    @Published var followers = 0
    
    static var following = AuthService.storeRoot.collection("following")
    static var followers = AuthService.storeRoot.collection("followers")
    
    static func followingCollection(userId: String) -> CollectionReference {
        return following.document(userId).collection("following")
    }
    
    static func followersCollection(userId: String) -> CollectionReference {
        return followers.document(userId).collection("followers")
    }
    
    func loadUserPost(userId: String) {
        
        PostService.loadUserPost(userId: userId) {
            (posts) in
            self.posts = posts
        }
        
        follows(userId: userId)
        followers(userId: userId)
    }
    
    func follows(userId: String) {
        ProfileService.followingCollection(userId: userId).getDocuments {
            (querysnapshot, err) in
            
            if let doc = querysnapshot?.documents {
                self.following = doc.count
            }
        }
    }
    
    func followers(userId: String) {
        ProfileService.followersCollection(userId: userId).getDocuments {
            (querysnapshot, err) in
            
            if let doc = querysnapshot?.documents {
                self.followers = doc.count
            }
        }
    }
}
