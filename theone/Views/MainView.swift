//
//  Main.swift
//  theone
//
//  Created by nguyenlam on 5/3/22.
//

import SwiftUI
import FirebaseAuth

struct MainView: View {
    // MARK: Properties
    @EnvironmentObject var session: SessionStore
    @StateObject var profileService = ProfileService()
    @State var posts = [PostModel]()
    
    // MARK: View
    var body: some View {
        ZStack {
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    ForEach(self.posts, id:\.postId) {
                        (post) in
                        PostCardImage(post: post)
                        PostCard(post: post)
                    }
                }
            }.navigationTitle("The One")
            .navigationBarColor(backgroundColor: .thirdly, titleColor: .primary)
            .onAppear{
//                self.profileService.loadUserPost(userId: Auth.auth().currentUser!.uid)
                PostService.loadAllPost() {
                    posts in
                    
                    self.posts = posts
                }
            }
        }
    }
}



struct Main_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
