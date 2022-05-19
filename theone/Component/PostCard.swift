//
//  PosrCard.swift
//  theone
//
//  Created by lephuoc on 5/8/22.
//

import SwiftUI

struct PostCard: View {
    @ObservedObject var postCardService = PostCardService()
    
    @State private var animation = false
    private let duration: Double = 0.3
    private var animationScale: CGFloat {
        postCardService.isLiked ? 0.5 : 2.0
    }
    
    init(post: PostModel) {
        self.postCardService.post = post
        self.postCardService.hasLikePost()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 30) {
                Button(action: {
                    self.animation = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() +
                                                    self.duration, execute: {
                                                        self.animation = false
                                                        
                                                        if self.postCardService.isLiked {
                                                            self.postCardService.unLike()
                                                        }
                                                        else {
                                                            self.postCardService.like()
                                                        }
                                                    })
                }) {
                    Image(systemName: (self.postCardService.isLiked) ? "heart.fill" : "heart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor((self.postCardService.isLiked) ? .red : .primary)
                }.scaleEffect(animation ? animationScale : 1)
                .animation(.easeIn(duration: duration))
                
                NavigationLink(destination: CommentView(post: self.postCardService.post,
                                                        postId: self.postCardService.post.postId)) {
                    Image(systemName: "bubble.right")
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.primary)
                }
                Spacer()
            }.padding(.leading, 16)
            
            if(self.postCardService.post.likeCount > 0) {
                Text("\(self.postCardService.post.likeCount) likes").padding(.horizontal)
                    .foregroundColor(.primary)
            }
        }
    }
}

//struct PosrCard_Previews: PreviewProvider {
//    static var previews: some View {
//        PostCard()
//    }
//}
