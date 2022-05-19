//
//  SignUpView.swift
//  theone
//
//  Created by nguyenlam on 4/29/22.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var username: String = ""
    @State private var profileImage: Image?
    @State private var pickedImage: Image?
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    @State private var imageData: Data = Data()
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Message"
    
    
    func loadImage() {
        guard let inputImage = pickedImage else {
            return
        }
        profileImage = inputImage
    }
    
    func errorCheck() -> String? {
        if email.trimmingCharacters(in: .whitespaces).isEmpty ||
            password.trimmingCharacters(in: .whitespaces).isEmpty ||
            username.trimmingCharacters(in: .whitespaces).isEmpty ||
            imageData.isEmpty {
            
            return "Please fill in all  fields and provide an image"
        }
        return nil
    }
    
    func clear() {
        self.email = ""
        self.username = ""
        self.password = ""
        self.imageData = Data()
        self.profileImage = Image(systemName: "person.circle.fill")
    }
    
    func signUp() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            return
        }
        
        AuthService.signUp(username: username, email: email, password: password, imageData: imageData, onSuccess: {
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
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: 20) {
                    VStack(alignment: .center) {
                        Text("Welcome").font(.system(size: 32, weight: .heavy)).foregroundColor(Color.primary)
                        Text("Sign Up To Start").font(.system(size: 16, weight: .medium)).foregroundColor(Color.secondary)
                    }
                    
                    VStack {
                        Group {
                            if profileImage != nil {
                                profileImage!.resizable()
                                    .clipShape(Circle())
                                    .frame(width: 150, height: 150)
                                    .padding(.top, 20)
                                    .onTapGesture {
                                        self.showingActionSheet = true
                                    }
                            }
                            else {
                                Image(systemName: "person.circle.fill").resizable()
                                    .clipShape(Circle())
                                    .frame(width: 150, height: 150)
                                    .padding(.top, 20)
                                    .foregroundColor(Color.primary)
                                    .onTapGesture {
                                        self.showingActionSheet = true
                                    }
                            }
                        }
                    }
                    
                    Group {
                        FormField(value: $username, icon: "person.fill", placeholder: "User name")
                        FormField(value: $email, icon: "envelope.fill", placeholder: "Email")
                        FormField(value: $password, icon: "lock.fill", placeholder: "Password",isSecure: true)
                    }
                    
                    Button(action:signUp) {
                        Text("Sign Up").font(.title).bold().modifier(ButtonModifiers())
                    }.alert(isPresented: $showingAlert) {
                        Alert(title: Text(alertTitle),
                              message: Text(error),
                              dismissButton: .default(Text("OK")))
                    }
                    
                    HStack {
                        Text("Already have an Account?").foregroundColor(Color.secondary)
                        Button(action: {
                                self.presentationMode.wrappedValue.dismiss()}) {
                            Text("Sign In.").font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Color.primary)
                        }
                    }
                    
                }.padding()
                
            }.navigationBarHidden(true)
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
                ImagePicker(pickerImage: self.$pickedImage,
                            showImagePicker: self.$showingImagePicker,
                            imageData: self.$imageData)
            }.actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(title: Text(""),
                            buttons: [
                                .default(Text("Choose A Photo")){
                                    self.sourceType = .photoLibrary
                                    self.showingImagePicker = true
                                },
                                .default(Text("Take A Photo")) {
                                    self.sourceType = .camera
                                    self.showingImagePicker = true
                                },
                                .cancel()
                            ])
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
