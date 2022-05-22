//
//  ForgotPasswordView.swift
//  theone
//
//  Created by nguyenlam on 5/22/22.
//

import SwiftUI

struct ForgotPasswordView: View {
    // MARK: Properties
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var email: String = ""
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Message"
    
    // MARK: Merthod
    func errorCheck() -> String? {
        if email.trimmingCharacters(in: .whitespaces).isEmpty {
            return "Please fill in all  fields"
        }
        return nil
    }
    
    func forgotPass() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            return
        }
        
        AuthService.forgotPassword(email: email, onSuccess: {
            self.error = "Successful"
            self.showingAlert = true
            return
        }, onError: {
            (errorMessage) in
            print("Error \(errorMessage)")
            self.error = errorMessage
            self.showingAlert = true
            return
        })
    }

    // MARK: View
    var body: some View {
        ZStack {
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                VStack(alignment: .center) {
                    Text("Forgot Password").font(.system(size: 32, weight: .heavy)).foregroundColor(Color.primary).padding(.bottom)
                    Text("To reset your password, enter your registered email address. We will email you the password reset link immediately.").font(.system(size: 16, weight: .medium)).foregroundColor(Color.secondary).padding(.horizontal, 30)
                }.padding(.bottom, 30)
                FormField(value: $email, icon: "envelope.fill", placeholder: "Email")
                
                Button(action: forgotPass) {
                    Text("Submit").font(.title).bold().modifier(ButtonModifiers())
                }.alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle),
                          message: Text(error),
                          dismissButton: .default(Text("OK")))
                }
                
                Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                    Text("Back").font(.title).bold()
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .frame(height: 20)
                        .padding()
                        .foregroundColor(.secondary)
                        .font(.system(size: 14, weight: .bold))
                        .background(Color.thirdly)
                        .cornerRadius(5)
                }
            }.padding()
        }.navigationBarHidden(true)
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
