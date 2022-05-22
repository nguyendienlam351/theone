//
//  PostCardImage.swift
//  theone
//
//  Created by lephuoc on 5/8/22.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct PostCardImage: View {
    // MARK: Properties
    var post: PostModel
    var user: User
    @State var isLinkActive = false
    
    init(post: PostModel) {
        self.post = post
        self.user = User(uid: post.ownerId, email: "", profileImageUrl: post.profile, username: post.username, bio: "")
    }
    
    func navigationUser() {
        if post.ownerId != Auth.auth().currentUser!.uid {
            self.isLinkActive = true
        }
    }
    
    // MARK: View
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                NavigationLink(destination: UsersProfileView(user: user), isActive: $isLinkActive) {
                    WebImage(url: URL(string: post.profile)!)
                        .resizable()
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                        .scaledToFill()
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .frame(width: 50, height: 50, alignment: .center)
                        .shadow(color: .secondary, radius: 3).padding(.leading)
                        .onTapGesture {
                            navigationUser()
                        }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(post.username).font(.headline).foregroundColor(.primary)
                            .onTapGesture {
                                navigationUser()
                            }
                        Text(Date(timeIntervalSince1970: post.date).timeAgo() + " ago").font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                
            }.padding(.top, 16)
            
            Text(post.caption).lineLimit(nil)
                .padding(.leading, 16)
                .padding(.trailing, 32).foregroundColor(.primary)
            
            WebImage(url: URL(string: post.mediaUrl)!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.size.width, height: 400, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .clipped()
        }.onAppear {
            self.isLinkActive = false
        }
    }
}

//struct PostCardImage_Previews: PreviewProvider {
//    static var previews: some View {
//        PostCardImage()
//    }
//}
