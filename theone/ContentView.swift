//
//  ContentView.swift
//  theone
//
//  Created by nguyenlam on 4/28/22.
//

import SwiftUI

struct ContentView: View {
    // MARK: Properties
    @EnvironmentObject var session: SessionStore
    
    func listen() {
        session.listen()
    }
    
    var body: some View {
        Group {
            if session.session != nil {
                HomeView()
            }
            else {
                SignInView()
            }
        }.onAppear(perform: listen)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
