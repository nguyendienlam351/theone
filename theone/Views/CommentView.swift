//
//  CommentView.swift
//  theone
//
//  Created by nguyennam on 5/14/22.
//

import SwiftUI

struct CommentView: View {
    @StateObject var commentService = CommentService()
    var post: PostModel?
    var postId: String?
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                ScrollView {
                    if !commentService.comments.isEmpty {
                        ForEach(commentService.comments) {
                            (comment) in
                            CommentCard(comment: comment)
                        }
                    }
                }
                CommentInput(post: post, postId: postId!)
            }.padding(.top)
            .navigationTitle("Comments")
            .onAppear {
                self.commentService.postId = self.post == nil ? self.postId : self.post?.postId
                self.commentService.loadComments()
            }
            .onDisappear {
                if self.commentService.listener != nil {
                    self.commentService.listener.remove()
                }
            }
        }
    }
}
//
//struct CommentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentView()
//    }
//}
