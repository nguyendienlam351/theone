//
//  ChangePasswordView.swift
//  theone
//
//  Created by nguyenlam on 5/18/22.
//

import SwiftUI

struct ChangePasswordView: View {
    // MARK: Properties
    @State private var password: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Message"
    
    // MARK: Merthod
    func errorCheck() -> String? {
        if password.trimmingCharacters(in: .whitespaces).isEmpty ||
            newPassword.trimmingCharacters(in: .whitespaces).isEmpty ||
        confirmPassword.trimmingCharacters(in: .whitespaces).isEmpty {
            return "Please fill in all  fields"
        }
        if newPassword != confirmPassword {
            return "Please enter the correct confirm password"
        }
        return nil
    }
    
    func clear() {
        self.password = ""
        self.newPassword = ""
        self.confirmPassword = ""
    }
    
    func changePass() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            return
        }
        
        AuthService.changePassword(password: password, newPassword: newPassword, onSuccess: {
            self.error = "Successful"
            self.showingAlert = true
            clear()
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
        ZStack{
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: 20) {
                    Text("Change Password").font(.largeTitle).foregroundColor(.primary)
                    
                    FormField(value: $password, icon: "lock.fill", placeholder: "Current password",isSecure: true)
                    
                    FormField(value: $newPassword, icon: "lock.fill", placeholder: "New password",isSecure: true)
                    FormField(value: $confirmPassword, icon: "lock.fill", placeholder: "Comfirm password",isSecure: true)
                    
                    Button(action: changePass) {
                        Text("Change").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold().modifier(ButtonModifiers())
                    }.alert(isPresented: $showingAlert) {
                        Alert(title: Text(alertTitle),
                              message: Text(error),
                              dismissButton: .default(Text("OK")))
                    }
                }.padding(.horizontal).padding(.vertical)
            }.navigationTitle("Change Password")
        }
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
