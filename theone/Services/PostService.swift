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
    static var Timeline = AuthService.storeRoot.collection("Timeline")
    
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
}
