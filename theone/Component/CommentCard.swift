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
                .frame(width: 45, height: 45, alignment: .center)
                .shadow(color: .black, radius: 3)
                .padding(.leading)
            
            VStack(alignment: .leading) {
                Text(comment.username).font(.headline).bold().foregroundColor(.primary)
                Text(comment.comment).font(.subheadline).foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text((Date(timeIntervalSince1970: comment.date)).timeAgo() + " ago").font(.caption)
            
        }.padding(.vertical, 10)
    }
}

//struct CommentCard_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentCard()
//    }
//}
