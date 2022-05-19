//
//  ChangePasswordView.swift
//  theone
//
//  Created by nguyenlam on 5/18/22.
//

import SwiftUI

struct ChangePasswordView: View {
    @State private var password: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: 20) {
                    Text("Change Password").font(.largeTitle).foregroundColor(.primary)
                    
                    FormField(value: $password, icon: "lock.fill", placeholder: "Current password",isSecure: true)
                    
                    FormField(value: $newPassword, icon: "lock.fill", placeholder: "New password",isSecure: true)
                    FormField(value: $confirmPassword, icon: "lock.fill", placeholder: "Comfirm password",isSecure: true)
                    
                    Button(action: {}) {
                        Text("Change").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold().modifier(ButtonModifiers())
                    }
                }.padding(.horizontal)
            }.navigationTitle("Change Password")
        }
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
