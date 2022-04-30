//
//  ContentView.swift
//  theone
//
//  Created by nguyenlam on 4/28/22.
//

import SwiftUI

struct ContentView: View {
    @State private var mail = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            FormField(value: $mail, icon: "mail", placeholder: "E-mail")
            FormField(value: $password, icon: "lock", placeholder: "Password", isSecure: true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
