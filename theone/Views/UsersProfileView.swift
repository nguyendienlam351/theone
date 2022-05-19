//
//  UsersProfileView.swift
//  theone
//
//  Created by nguyennam on 5/12/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct UsersProfileView: View {
    var user: User
    @StateObject var profileService = ProfileService()
    @State private var selecttion = 1
    
    let threeItem = [GridItem(), GridItem(), GridItem()]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            ScrollView {
                ProfileHeader(user: user,
                              postsCount: profileService.posts.count,
                              following: $profileService.following,
                              followers: $profileService.followers)
                HStack {
                    FollowButton(user: user, followCheck: $profileService.followCheck, followingCount: $profileService.following, followersCount: $profileService.followers)
                }.padding(.horizontal)
                
                Picker("", selection: $selecttion) {
                    Image(systemName: "circle.grid.2x2.fill").tag(0)
                    Image(systemName: "person.fill").tag(1)
                }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal)
                
                if selecttion == 0 {
                    LazyVGrid(columns: threeItem) {
                        ForEach(self.profileService.posts, id:\.postId) {
                            (post) in
                            WebImage(url: URL(string: post.mediaUrl)!)
                                .resizable()
                                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                .frame(width: UIScreen.main.bounds.width/3,
                                       height: UIScreen.main.bounds.height/4).clipped()
                        }
                    }
                }
                else {
                    ScrollView {
                        VStack {
                            ForEach(self.profileService.posts, id:\.postId) {
                                (post) in
                                PostCardImage(post: post)
                                PostCard(post: post)
                            }
                        }
                    }
                }
            }.navigationBarTitle(Text(self.user.username))
            .accentColor(.primary)
            .onAppear {
                self.profileService.loadUserPost(userId: self.user.uid)
            }
        }
    }
    
}

//struct UsersProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        UsersProfileView()
//    }
//}
