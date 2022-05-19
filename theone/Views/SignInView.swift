//
//  SignInView.swift
//  theone
//
//  Created by nguyenlam on 4/28/22.
//

import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Message"
    
    func errorCheck() -> String? {
        if email.trimmingCharacters(in: .whitespaces).isEmpty ||
            password.trimmingCharacters(in: .whitespaces).isEmpty {
            return "Please fill in all  fields"
        }
        return nil
    }
    
    func clear() {
        self.email = ""
        self.password = ""
    }
    
    func signIn() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            return
        }
        
        AuthService.signIn(email: email, password: password, onSuccess: {
            (user) in
            self.clear()
        }) {
            (errorMessage) in
            print("Error \(errorMessage)")
            self.error = errorMessage
            self.showingAlert = true
            return
        }
    }
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                VStack(spacing: 20) {
                    Image("logo").resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150, alignment: .trailing)
                    
                    VStack(alignment: .center) {
                        Text("Welcome Back").font(.system(size: 32, weight: .heavy)).foregroundColor(Color.primary)
                        Text("SignIn To Continue").font(.system(size: 16, weight: .medium)).foregroundColor(Color.secondary)
                        
                    }
                    
                    FormField(value: $email, icon: "envelope.fill", placeholder: "Email")
                    FormField(value: $password, icon: "lock.fill", placeholder: "Password",isSecure: true).accentColor(Color.primary)
                    
                    Button(action: signIn) {
                        Text("Sign In").font(.title).bold().modifier(ButtonModifiers())
                    }.alert(isPresented: $showingAlert) {
                        Alert(title: Text(alertTitle),
                              message: Text(error),
                              dismissButton: .default(Text("OK")))
                    }
                    
                    HStack {
                        Text("New?").foregroundColor(Color.secondary)
                        NavigationLink(
                            destination: SignUpView()) {
                            Text("Create an Account.").font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Color.primary)
                        }
                    }
                }.padding()
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
