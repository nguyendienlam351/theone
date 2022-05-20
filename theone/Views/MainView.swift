//
//  Main.swift
//  theone
//
//  Created by nguyenlam on 5/3/22.
//

import SwiftUI
import FirebaseAuth

struct MainView: View {
    @EnvironmentObject var session: SessionStore
    @StateObject var profileService = ProfileService()
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    ForEach(self.profileService.posts, id:\.postId) {
                        (post) in
                        PostCardImage(post: post)
                        PostCard(post: post)
                    }
                }
            }.navigationTitle("The One")
            .navigationBarColor(backgroundColor: .thirdly, titleColor: .primary)
            .onAppear{
                self.profileService.loadUserPost(userId: Auth.auth().currentUser!.uid)
            }
        }
    }
}



struct Main_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
