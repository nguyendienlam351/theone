//
//  Profile.swift
//  theone
//
//  Created by nguyenlam on 5/3/22.
//

import SwiftUI
import FirebaseAuth
import SDWebImageSwiftUI

struct ProfileView: View {
    // MARK: Properties
    @EnvironmentObject var session: SessionStore
    @State private var selecttion = 1
    @StateObject var profileService = ProfileService()
    @State var isLinkActive = false
    
    let threeItem = [GridItem(), GridItem(), GridItem()]
    
    // MARK: View
    var body: some View {
        ZStack {
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack{
                    ProfileHeader(user: self.session.session,
                                  postsCount: profileService.posts.count,
                                  following: $profileService.following,
                                  followers: $profileService.followers)
                    
                    VStack(alignment: .leading) {
                        Text(session.session?.bio ?? "").font(.headline).lineLimit(1).foregroundColor(Color.primary)
                    }
                    NavigationLink(destination: EditProfileView(session: self.session.session), isActive: $isLinkActive) {
                        Button(action: {self.isLinkActive = true}) {
                            Text("Edit Profile").font(.title).bold().modifier(ButtonModifiers())
                                .padding(.horizontal)
                        }
                    }
                    
                    Picker("", selection: $selecttion) {
                        Image(systemName: "circle.grid.2x2.fill").tag(0).accentColor(.primary)
                        Image(systemName: "person.fill").tag(1).foregroundColor(.primary)
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
            .navigationBarItems(trailing: Button(action: {
                self.session.logout()
            }) {
                Image(systemName: "arrow.right.circle.fill")
            }).onAppear{
                if let userId = Auth.auth().currentUser?.uid {
                    self.profileService.loadUserPost(userId: userId)
                }
            }
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
