//
//  FollowButton.swift
//  theone
//
//  Created by nguyennam on 5/12/22.
//

import SwiftUI

struct FollowButton: View {
    @ObservedObject var followService = FollowService()
    
    var user: User
    @Binding var followingCount: Int
    @Binding var followersCount: Int
    @Binding var followCheck: Bool
    
    init(user: User,followCheck: Binding<Bool>, followingCount: Binding<Int>, followersCount: Binding<Int>) {
        self.user = user
        self._followCheck = followCheck
        self._followingCount = followingCount
        self._followersCount = followersCount
    }
    
    func follow() {
        if !self.followCheck {
            followService.follow(userId: user.uid, followingCount: {
                (followingCount) in
                self.followingCount = followingCount
            }, followersCount: {
                (followersCount) in
                self.followersCount = followersCount
            })
            
            self.followCheck = true
        }
        else {
            followService.unfollow(userId: user.uid, followingCount: {
                (followingCount) in
                self.followingCount = followingCount
            }, followersCount: {
                (followersCount) in
                self.followersCount = followersCount
            })
            
            self.followCheck = false
        }
    }
    
    var body: some View {
        Button(action: follow) {
            Text((self.followCheck) ? "Unfollow" : "Follow").font(.title).bold().modifier(ButtonModifiers())
        }
    }
}

//struct FollowButton_Previews: PreviewProvider {
//    static var previews: some View {
//        FollowButton()
//    }
//}
