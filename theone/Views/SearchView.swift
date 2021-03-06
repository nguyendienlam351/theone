//
//  UserProfile.swift
//  theone
//
//  Created by nguyenlam on 5/11/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct SearchView: View {
    // MARK: Properties
    @State private var value: String = ""
    @State var users: [User] = []
    @State var isLoading = false
    
    // MARK: Merthod
    func searchUser() {
        isLoading = true
        
        SearchSevice.searchUser(input: value) {
            (users) in
            self.isLoading = false
            self.users = users
        }
    }
    
    // MARK: View
    var body: some View {
        ZStack {
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(alignment: .leading) {
                    SearchBar(users: $users, value: $value).padding(.vertical)
                        .onChange(of: value, perform: {
                            new in
                            searchUser()
                        })
                    
                    if !isLoading {
                        ForEach(users, id:\.uid) {
                            user in
                            
                            NavigationLink(destination: UsersProfileView(user: user)) {
                                HStack(spacing: 30) {
                                    WebImage(url: URL(string: user.profileImageUrl))
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                        .frame(width: 60, height: 60, alignment: .center)
                                    
                                    Text(user.username).font(.headline).bold()
                                }.padding(.horizontal)
                            }
                            Divider().background(Color.thirdly)
                        }
                    }
                }
            }.navigationTitle("User Search").accentColor(Color.primary)
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
