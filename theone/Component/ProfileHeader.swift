//
//  ProfileHeader.swift
//  theone
//
//  Created by lephuoc on 5/8/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileHeader: View {
    var user: User?
    var postsCount: Int
    @Binding var following: Int
    @Binding var followers: Int
    
    var body: some View {
        HStack {
            VStack {
                if user != nil {
                    WebImage(url: URL(string: user!.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .frame(width: 80, height: 80, alignment: .center)
                        .shadow(color: .secondary, radius: 3)
                        .padding(.leading)
                    
                    Text(user!.username).font(.headline).bold().padding(.leading).foregroundColor(.primary)
                } else {
                    Color.init(red: 0.9, green: 0.9, blue: 0.9)
                        .frame(width: 80, height: 80, alignment: .center)
                        .padding(.leading)
                }
            }
            VStack {
                HStack {
                    Spacer()
                    VStack {
                        Text("Posts").font(.footnote).foregroundColor(.primary)
                        Text("\(postsCount)").font(.title).bold().foregroundColor(.primary)
                    }.padding(.top, 60)
                    
                    Spacer()
                    VStack {
                        Text("Followers").font(.footnote).foregroundColor(.primary)
                        Text("\(followers)").font(.title).bold().foregroundColor(.primary)
                    }.padding(.top, 60)
                    
                    Spacer()
                    VStack {
                        Text("Following").font(.footnote).foregroundColor(.primary)
                        Text("\(following)").font(.title).bold().foregroundColor(.primary)
                    }.padding(.top, 60)
                    Spacer()
                }
            }
        }.padding(.top)
        
    }
}

//struct ProfileHeader_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileHeader()
//    }
//}
