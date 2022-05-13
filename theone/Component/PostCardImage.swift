//
//  PostCardImage.swift
//  theone
//
//  Created by lephuoc on 5/8/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct PostCardImage: View {
    var post: PostModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                WebImage(url: URL(string: post.profile)!)
                    .resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .scaledToFill()
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .frame(width: 50, height: 50, alignment: .center)
                    .shadow(color: .gray, radius: 3).padding(.leading)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(post.username).font(.headline)
                    Text(Date(timeIntervalSince1970: post.date).timeAgo() + " ago").font(.subheadline)
                        .foregroundColor(.gray)
                }
                
            }.padding(.top, 16)
            
            Text(post.caption).lineLimit(nil)
                .padding(.leading, 16)
                .padding(.trailing, 32)
            
            WebImage(url: URL(string: post.mediaUrl)!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.size.width, height: 400, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .clipped()
        }
    }
}

//struct PostCardImage_Previews: PreviewProvider {
//    static var previews: some View {
//        PostCardImage()
//    }
//}
