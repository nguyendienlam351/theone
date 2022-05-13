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
    
    @Published var followCheck = false
    
    static var following = AuthService.storeRoot.collection("following")
    static var followers = AuthService.storeRoot.collection("followers")
    
    static func followingCollection(userId: String) -> CollectionReference {
        return following.document(userId).collection("following")
    }
    
    static func followersCollection(userId: String) -> CollectionReference {
        return followers.document(userId).collection("followers")
    }
    
    static func followingId(userId: String) -> DocumentReference {
        return following.document(Auth.auth().currentUser!.uid).collection("following").document(userId)
    }
    
    static func followersId(userId: String) -> DocumentReference {
        return followers.document(userId).collection("followers").document(Auth.auth().currentUser!.uid)
    }
    
    func followState(userId: String) {
        ProfileService.followersId(userId: userId).getDocument {
            (document, error) in
            
            if let doc = document , doc.exists {
                self.followCheck = true
            }
            else {
                self.followCheck = false
            }
        }
    }
    
    func loadUserPost(userId: String) {
        
        PostService.loadUserPost(userId: userId) {
            (posts) in
            self.posts = posts
        }
        followState(userId: userId)
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
