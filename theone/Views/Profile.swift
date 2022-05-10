//
//  Profile.swift
//  theone
//
//  Created by nguyenlam on 5/3/22.
//

import SwiftUI
import FirebaseAuth
import SDWebImageSwiftUI

struct Profile: View {
    @EnvironmentObject var session: SessionStore
    @State private var selecttion = 1
    @StateObject var profileService = ProfileService()
    
    let threeItem = [GridItem(), GridItem(), GridItem()]
    
    var body: some View {
        ScrollView {
            VStack{
                ProfileHeader(user: self.session.session,
                              postsCount: profileService.posts.count,
                              following: $profileService.following,
                              followers: $profileService.followers)
                
                Button(action:{}) {
                    Text("Edit Profile").font(.title).modifier(ButtonModifiers())
                        .padding(.horizontal)
                }
                
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
                else if self.session.session != nil {
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
            }
        }.navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: Button(action: {}) {
            Image(systemName: "person.fill")
        }, trailing: Button(action: {
            self.session.logout()
        }) {
            Image(systemName: "arrow.right.circle.fill")
        }).onAppear{
            self.profileService.loadUserPost(userId: Auth.auth().currentUser!.uid)
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
