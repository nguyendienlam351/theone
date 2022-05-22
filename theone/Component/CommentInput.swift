//
//  CommentInput.swift
//  theone
//
//  Created by nguyennam on 5/14/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct CommentInput: View {
    // MARK: Properties
    @EnvironmentObject var session: SessionStore
    @ObservedObject var commentService = CommentService()
    @State private var text: String = ""
    @State private var disableEditText = false
    
    // MARK: Constructor
    init(post: PostModel?, postId: String ) {
        if post != nil {
            commentService.post = post
        }
        else {
            handleInput(postId: postId)
        }
    }
    
    // MARK: Merthod
    func handleInput(postId: String) {
        PostService.loadPost(postId: postId) {
            (post) in
            self.commentService.post = post
        }
    }
    
    func sendComment() {
        if !text.isEmpty {
            commentService.addComment(comment: text) {
                self.text = ""
            }
        }
    }
    
    // MARK: View
    var body: some View {
        HStack {
            WebImage(url: URL(string: session.session!.profileImageUrl)!)
                .resizable()
                .scaledToFill()
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .frame(width: 50, height: 50, alignment: .center)
                .shadow(color: .black, radius: 3)
                .padding(.leading)
            HStack {
                EditText(value: $text, placeholder: "", height: 50, disable: $disableEditText)
                
                Button(action: sendComment) {
                    Image(systemName: "paperplane").imageScale(.large).padding(.trailing)
                }
            }
        }
    }
}

//struct CommentInput_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentInput()
//    }
//}
