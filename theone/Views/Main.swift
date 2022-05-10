//
//  Main.swift
//  theone
//
//  Created by nguyenlam on 5/3/22.
//

import SwiftUI
import FirebaseAuth

struct Main: View {
    var body: some View {
        Text("Main")
    }
}

//@EnvironmentObject var session: SessionStore
//@StateObject var profileService = ProfileService()
//
//var body: some View {
//    ScrollView {
//        VStack {
//            ForEach(self.profileService.posts, id:\.postId) {
//                (post) in
//                PostCardImage(post: post)
//                PostCard(post: post)
//            }
//        }
//    }.navigationTitle("")
//    .navigationBarHidden(true)
//    .onAppear{
//        self.profileService.loadUserPost(userId: Auth.auth().currentUser!.uid)
//    }
//}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
