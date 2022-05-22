//
//  ChatView.swift
//  theone
//
//  Created by nguyenlam on 5/21/22.
//

import SwiftUI
import Combine

struct ChatView: View {
    // MARK: Properties
    @StateObject var chatService = ChatService()
    
    var recipientId = ""
    var recipientProfile = ""
    var recipientUsername = ""
    @State var text: String = ""
    @State private var pickedImage: Image?
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    @State private var imageData: Data = Data()
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Message"
    @State private var canclelabels: AnyCancellable?
    @State private var disableEditText = false
    
    // MARK: Merthod
    func errorCheck() -> String? {
        if text.trimmingCharacters(in: .whitespaces).isEmpty {
            return "Please add some text"
        }
        return nil
    }
    
    func loadImage() {
        if pickedImage != nil {
            self.text = "Send a photo"
            self.disableEditText = true
        }
    }
    
    func clear() {
        self.text = ""
        self.imageData = Data()
        self.disableEditText = false
    }
    
    func sentMessage() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            return
        }
        
        chatService.sendMessage(message: text, recipientId: recipientId, recipientProfile: recipientProfile, recipientName: recipientUsername, onSuccess: {
            self.clear()
        }) {
            (err) in
            self.error = err
            self.showingAlert = true
            return
        }
    }
    
    func sendPhoto() {
        if !imageData.isEmpty {
            chatService.sendPhotoMessage(imageData: imageData, recipientId: recipientId, recipientProfile: recipientProfile, recipientName: recipientUsername, onSuccess: {}) {
                (err) in
                self.error = err
                self.showingAlert = true
                return
            }
            clear()
        }
    }
    
    // MARK: View
    var body: some View {
        ZStack {
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            VStack {
                if !chatService.chats.isEmpty {
                    ScrollView {
                        ScrollViewReader {
                            (value) in
                            ForEach(chatService.chats, id:\.messageId) {
                                (chat) in
                                if !chat.isPhoto {
                                    ChatMessageCard(chat: chat)
                                }
                                else {
                                    ChatPhotoCard(chat: chat)
                                }
                            }.onAppear {
                                canclelabels = chatService.$chats.sink {
                                    chat in
                                    
                                    DispatchQueue.main.async {
                                        withAnimation {
                                            value.scrollTo(chat[chat.endIndex - 1].messageId, anchor: .bottom)
                                        }
                                    }
                                }
                            }
                        }
                    }.padding(.top)
                }
                else {
                    Text("Write something").bold().padding(.top)
                }
                
                Spacer()
                
                HStack {
                    Image(systemName: "camera.fill")
                        .imageScale(.large)
                        .padding(.leading)
                        .foregroundColor(Color.primary)
                        .onTapGesture {
                            self.showingActionSheet = true
                        }
                    HStack {
                        VStack {
                            EditText(value: $text, placeholder: "", height: 50, disable: $disableEditText)
                        }.onTapGesture {
                            if !imageData.isEmpty {
                                clear()
                            }
                        }
                        Button(action: {
                            if imageData.isEmpty {
                                sentMessage()
                            } else{
                                sendPhoto()
                            }
                        }) {
                            Image(systemName: "paperplane")
                                .imageScale(.large)
                                .padding(.trailing)
                                .foregroundColor(Color.primary)
                        }.alert(isPresented: $showingAlert) {
                            Alert(title: Text(alertTitle),
                                  message: Text(error),
                                  dismissButton: .default(Text("OK")))
                        }
                    }
                }
            }.sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
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
            }.onAppear {
                self.chatService.recipientId = self.recipientId
                self.chatService.loadChats()
            }.onDisappear {
                if self.chatService.listener != nil {
                    self.chatService.listener.remove()
                }
            }
        }
    }
}

//struct ChatView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatView()
//    }
//}
