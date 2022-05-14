//
//  PostService.swift
//  theone
//
//  Created by nguyenlam on 5/5/22.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage

class PostService {
    static var Post = AuthService.storeRoot.collection("posts")
    static var AllPost = AuthService.storeRoot.collection("allPost")
    static var Timeline = AuthService.storeRoot.collection("timeline")
    
    static func PostsUserId(userId: String) -> DocumentReference {
        return Post.document(userId)
    }
    
    static func timelineUserId(userId: String) -> DocumentReference {
        return Timeline.document(userId)
    }
    
    static func uploadPost(caption: String, imageData: Data, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let postId = PostService.PostsUserId(userId: userId).collection("posts").document().documentID
        
        let storagePostRef = StorageService.storagePostId(postId: postId)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        StorageService.savePostPhoto(userId: userId, caption: caption, postId: postId, imageData: imageData, metaData: metadata, storagePostRef: storagePostRef, onSuccess: onSuccess, onError: onError)
    }
    
    static func loadPost(postId: String, onSuccess: @escaping(_ post: PostModel) -> Void) {
        PostService.AllPost.document(postId).getDocument {
            (snapshot, err) in
            guard let snap = snapshot else {
                print("error")
                return
            }
            
            let dict = snap.data()
            
            guard let decoded = try? PostModel.init(fromDictionary: dict!) else {
                return
            }
            
            onSuccess(decoded)
        }
    }
    
    static func loadUserPost(userId: String, onSuccess: @escaping(_ posts: [PostModel]) ->Void) {
        
        PostService.PostsUserId(userId: userId).collection("posts").getDocuments {
            (snapshot, error) in
            
            guard let snap = snapshot else {
                print("Error")
                return
            }
            
            var posts = [PostModel]()
            
            for doc in snap.documents {
                let dict = doc.data()
                
                guard let decoder = try? PostModel.init(fromDictionary: dict) else {
                    return
                }
                
                posts.append(decoder)
            }
            onSuccess(posts)
        }
    }
}
