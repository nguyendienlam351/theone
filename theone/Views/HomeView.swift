//
//  HomeView.swift
//  theone
//
//  Created by nguyenlam on 5/2/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        VStack {
            Text("Home View")
            Button(action: session.logout) {
                Text("Sign Out").font(.title).modifier(ButtonModifiers())
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
