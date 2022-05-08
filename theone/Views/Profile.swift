//
//  Profile.swift
//  theone
//
//  Created by nguyenlam on 5/3/22.
//

import SwiftUI

struct Profile: View {
    @EnvironmentObject var session: SessionStore
    @State private var selecttion = 1
    
    var body: some View {
        ScrollView {
            VStack{
                ProfileHeader(user: self.session.session)
                
                Button(action:{}) {
                    Text("Edit Profile").font(.title).modifier(ButtonModifiers())
                        .padding(.horizontal)
                }
                
                Picker("", selection: $selecttion) {
                    Image(systemName: "circle.grid.2x2.fill").tag(0)
                    Image(systemName: "person.fill").tag(1)
                }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal)
            }
        }.navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: Button(action: {}) {
            Image(systemName: "person.fill")
        }, trailing: Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
            Image(systemName: "arrow.right.circle.fill")
        })
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
