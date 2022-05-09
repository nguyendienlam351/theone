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
    @Published var post: PostModel!
    @Published var isLiked = false
    
    func hasLikePost() {
        isLiked = (post.likes["\(Auth.auth().currentUser!.uid)"] == true) ? true : false
    }
    
    func like() {
        post.likeCount += 1
        isLiked = true
        
        PostService.PostsUserId(userId: post.ownerId).collection("posts").document(post.postId)
            .updateData(["likeCount": post.likeCount, "likes.\(Auth.auth().currentUser!.uid)": true])
        
        PostService.AllPost.document(post.postId)
            .updateData(["likeCount": post.likeCount, "likes.\(Auth.auth().currentUser!.uid)": true])
        
        PostService.timelineUserId(userId: post.postId).collection("timeline").document(post.postId)
            .updateData(["likeCount": post.likeCount, "likes.\(Auth.auth().currentUser!.uid)": true])
    }
    
    func unLike() {
        post.likeCount -= 1
        isLiked = false
        
        PostService.PostsUserId(userId: post.ownerId).collection("posts").document(post.postId)
            .updateData(["likeCount": post.likeCount, "likes.\(Auth.auth().currentUser!.uid)": false])
        
        PostService.AllPost.document(post.postId)
            .updateData(["likeCount": post.likeCount, "likes.\(Auth.auth().currentUser!.uid)": false])
        
        PostService.timelineUserId(userId: post.postId).collection("timeline").document(post.postId)
            .updateData(["likeCount": post.likeCount, "likes.\(Auth.auth().currentUser!.uid)": false])
    }
}
