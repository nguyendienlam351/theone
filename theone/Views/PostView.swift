//
//  Add.swift
//  theone
//
//  Created by nguyenlam on 5/3/22.
//

import SwiftUI

struct PostView: View {
    // MARK: Properties
    @State private var postImage: Image?
    @State private var pickedImage: Image?
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    @State private var imageData: Data = Data()
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Message"
    @State private var text = ""
    
    // MARK: Constructor
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    // MARK: Merthod
    func loadImage() {
        guard let inputImage = pickedImage else {
            return
        }
        postImage = inputImage
    }
    
    func errorCheck() -> String? {
        if text.trimmingCharacters(in: .whitespaces).isEmpty ||
            imageData.isEmpty {
            return "Please add a caption and provide an image"
        }
        return nil
    }
    
    func clear() {
        self.text = ""
        self.imageData = Data()
        self.postImage = nil
    }
    
    func uploadPost() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            return
        }
        // Firebase
        PostService.uploadPost(caption: text, imageData: imageData, onSuccess: {
            self.error = "Successful"
            self.showingAlert = true
            clear()
            return
        }) {
            (errorMessage) in
            print("Error \(errorMessage)")
            self.error = errorMessage
            self.showingAlert = true
            return
        }
    }
    
    // MARK: View
    var body: some View {
        ZStack {
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            ScrollView {
                Text("Upload A Post").font(.largeTitle).foregroundColor(.primary)
                VStack {
                    if postImage != nil {
                        postImage!.resizable()
                            .frame(height: 200)
                            .onTapGesture {
                                self.showingActionSheet = true
                            }
                    }
                    else {
                        Image(systemName: "photo.fill").resizable()
                            .frame(height: 200)
                            .foregroundColor(.primary)
                            .onTapGesture {
                                self.showingActionSheet = true
                            }
                    }
                }
                VStack {
                    TextEditor(text: $text)
                        .frame(height: 200, alignment: .center)
                        .lineSpacing(10)
                        .autocapitalization(.words)
                        .disableAutocorrection(true)
                        .foregroundColor(Color.primary)
                        .padding()
                    
                }.overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.secondary, lineWidth: 3)
                )
                
                Button(action: uploadPost) {
                    Text("Upload Post").font(.title).bold().modifier(ButtonModifiers())
                }.alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle),
                          message: Text(error),
                          dismissButton: .default(Text("OK")))
                }
            }.padding(.horizontal).padding(.top)
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
        }.navigationBarHidden(true)
    }
}

struct Post_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
