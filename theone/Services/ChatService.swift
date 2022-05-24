//
//  ChatService.swift
//  theone
//
//  Created by lequy on 5/16/22.
//

import Foundation
import Firebase


class ChatService: ObservableObject {
    // MARK: Properties
    @Published var isLoaing = false
    @Published var chats: [ChatModel] = []
    
    var listener: ListenerRegistration!
    var recipientId = ""
    
    static var chats = AuthService.storeRoot.collection("chats")
    
    // MARK: Merthod
    static func conversation(sender: String, recipient: String) -> CollectionReference {
        return chats.document(sender).collection("chats").document(recipient).collection("conversation")
    }
    
    func loadChats() {
        self.chats = []
        self.isLoaing = true
        
        self.getChats(userId: recipientId, onSuccess: {
            (chats) in
            if self.chats.isEmpty {
                self.chats = chats
            }
        }, onError: {
            (err) in
            print("Error \(err)")
        }, newChat: {
            (chat) in
            if !self.chats.isEmpty {
                self.chats.append(chat)
            }
        }) {
            (listener) in
            self.listener = listener
        }
        
    }
    
    func sendMessage(message: String, recipientId: String, recipientProfile: String, recipientName: String, onSuccess: @escaping() -> Void, onError: @escaping(_ error: String) -> Void) {
        
        guard let senderId = Auth.auth().currentUser?.uid else {
            return
        }
        
        guard let senderUsername = Auth.auth().currentUser?.displayName else {
            return
        }
        
        guard let senderProfile = Auth.auth().currentUser?.photoURL!.absoluteString else {
            return
        }
        
        let messageId = ChatService.conversation(sender: senderId, recipient: recipientId).document().documentID
        
        let chat = ChatModel(messageId: messageId, textMessage: message, profile: senderProfile, photoUrl: "", sender: senderId, username: senderUsername, timestamp: Date().timeIntervalSince1970, isPhoto: false)
        
        guard let dict = try? chat.asDictionary() else {
            return
        }
        
        ChatService.conversation(sender: recipientId, recipient: senderId).document(messageId).setData(dict) {
            (error) in
            
            if error == nil {
                ChatService.conversation(sender: senderId, recipient: recipientId).document(messageId).setData(dict)
                
                onSuccess()
            }
            else {
                onError(error!.localizedDescription)
            }
        }
    }
    
    func sendPhotoMessage(imageData: Data, recipientId: String, recipientProfile: String, recipientName: String, onSuccess: @escaping() -> Void, onError: @escaping(_ error: String) -> Void) {
        
        guard let senderId = Auth.auth().currentUser?.uid else {
            return
        }
        
        guard let senderUsername = Auth.auth().currentUser?.displayName else {
            return
        }
        
        guard let senderProfile = Auth.auth().currentUser?.photoURL!.absoluteString else {
            return
        }
        
        let messageId = ChatService.conversation(sender: senderId, recipient: recipientId).document().documentID
        
        let storageChatRef = StorageService.storageChatId(chatId: messageId)
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        StorageService.saveChatPhoto(messageId: messageId, recipientId: recipientId, recipientProfile: recipientProfile, recipientName: recipientName, senderProfile: senderProfile, senderId: senderId, senderUsername: senderUsername, imageData: imageData, metadata: metaData, storageChatRef: storageChatRef, onSuccess: onSuccess, onError: onError)
        
    }
    
    func getChats(userId: String, onSuccess: @escaping([ChatModel]) -> Void, onError: @escaping(_ error: String) -> Void, newChat: @escaping(ChatModel) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        let listenerChat = ChatService.conversation(sender: Auth.auth().currentUser!.uid, recipient: userId).order(by: "timestamp", descending: false).addSnapshotListener {
            (qs, err) in
            
            guard let snapshot = qs else {
                return
            }
            
            var chats = [ChatModel]()
            
            snapshot.documentChanges.forEach {
                (diff) in
                
                if diff.type == .added {
                    let dict = diff.document.data()
                    
                    guard let decoded = try? ChatModel.init(fromDictionary: dict) else {
                        return
                    }
                    newChat(decoded)
                    chats.append(decoded)
                }
                if diff.type == .modified {
                    print("modified")
                }
                if diff.type == .removed {
                    print("removed")
                }
            }
            onSuccess(chats)
        }
        listener(listenerChat)
    }
    
}
