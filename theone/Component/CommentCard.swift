//
//  CommentCard.swift
//  theone
//
//  Created by nguyennam on 5/14/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct CommentCard: View {
    var comment: CommentModel
    
    var body: some View {
        HStack {
            WebImage(url: URL(string: comment.profile)!)
                .resizable()
                .scaledToFill()
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .frame(width: 30, height: 30, alignment: .center)
                .shadow(color: .black, radius: 3)
                .padding(.leading)
            
            VStack(alignment: .leading) {
                Text(comment.username).font(.subheadline).bold()
                Text(comment.comment).font(.caption)
            }
            
            Spacer()
            
            Text((Date(timeIntervalSince1970: comment.date)).timeAgo() + " ago").font(.subheadline)
            
        }
    }
}

//struct CommentCard_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentCard()
//    }
//}
