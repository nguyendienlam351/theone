//
//  FollowService.swift
//  theone
//
//  Created by nguyennam on 5/12/22.
//

import Foundation
import Firebase

class FollowService: ObservableObject {
    // MARK: Merthod
    func updateFollowCount(userId: String, followingCount: @escaping(_ followingCount: Int) -> Void, followersCount: @escaping(_ followersCount: Int) -> Void) {
        
        ProfileService.followingCollection(userId: userId).getDocuments {
            (snap, error) in
            
            if let doc = snap?.documents {
                followingCount(doc.count)
            }
        }
        
        ProfileService.followersCollection(userId: userId).getDocuments {
            (snap, error) in
            
            if let doc = snap?.documents {
                followersCount(doc.count)
            }
        }
    }
    
    func follow(userId: String, followingCount: @escaping(_ followingCount: Int) -> Void, followersCount: @escaping(_ followersCount: Int) -> Void) {
        ProfileService.followingId(userId: userId).setData([:]) {
            (err) in
            
            if err == nil {
                self.updateFollowCount(userId: userId, followingCount: followingCount, followersCount: followersCount)
            }
        }
        
        ProfileService.followersId(userId: userId).setData([:]) {
            (err) in
            
            if err == nil {
                self.updateFollowCount(userId: userId, followingCount: followingCount, followersCount: followersCount)
            }
        }
    }
    
    func unfollow(userId: String, followingCount: @escaping(_ followingCount: Int) -> Void, followersCount: @escaping(_ followersCount: Int) -> Void) {
        
        ProfileService.followingId(userId: userId).getDocument {
            (document, err) in
            
            if let doc = document, doc.exists {
                doc.reference.delete()
                
                self.updateFollowCount(userId: userId, followingCount: followingCount, followersCount: followersCount)
            }
        }
        
        ProfileService.followersId(userId: userId).getDocument {
            (document, err) in
            
            if let doc = document, doc.exists {
                doc.reference.delete()
                
                self.updateFollowCount(userId: userId, followingCount: followingCount, followersCount: followersCount)
            }
        }
    }
    
    static func getUserFollowing(onSuccess: @escaping(_ userIds: [String]) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        ProfileService.followingCollection(userId: userId).getDocuments {
            (snapshot, error) in
            
            guard let snap = snapshot else {
                print("Error")
                return
            }
            
            
            var userIds = [String]()
            
            userIds.append(userId)
            for doc in snap.documents {
                userIds.append(doc.documentID)
            }
            
            onSuccess(userIds)
        }
    }
}
