//
//  PostCardService.swift
//  theone
//
//  Created by lephuoc on 5/8/22.
//

import Foundation
import Firebase
import SwiftUI

class PostCardService: ObservableObject {
    // MARK: Properties
    @Published var post: PostModel!
    @Published var isLiked = false
    
    // MARK: Merthod
    func hasLikePost() {
        if Auth.auth().currentUser?.uid != nil {
            isLiked = (post.likes["\(Auth.auth().currentUser!.uid)"] == true) ? true : false
        }
    }
    
    func like() {
        post.likeCount += 1
        isLiked = true
        
        PostService.PostsUserId(userId: post.ownerId).collection("posts").document(post.postId)
            .updateData(["likeCount": post.likeCount, "likes.\(Auth.auth().currentUser!.uid)": true])
        
        PostService.AllPost.document(post.postId)
            .updateData(["likeCount": post.likeCount, "likes.\(Auth.auth().currentUser!.uid)": true])
    }
    
    func unLike() {
        post.likeCount -= 1
        isLiked = false
        
        PostService.PostsUserId(userId: post.ownerId).collection("posts").document(post.postId)
            .updateData(["likeCount": post.likeCount, "likes.\(Auth.auth().currentUser!.uid)": false])
        
        PostService.AllPost.document(post.postId)
            .updateData(["likeCount": post.likeCount, "likes.\(Auth.auth().currentUser!.uid)": false])
        
    }
}
