//
//  AuthService.swift
//  theone
//
//  Created by nguyenlam on 4/30/22.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class AuthService {
    // MARK: Properties
    static var storeRoot = Firestore.firestore()
    
    static func getUserId(userId: String) -> DocumentReference {
        return storeRoot.collection("users").document(userId)
    }
    
    // MARK: Merthod
    static func signUp(username: String, email: String, password: String, imageData: Data, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {
            (authData, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            guard let userId = authData?.user.uid else {
                return
            }
            
            let storageProfileUserId = StorageService.storageProfileId(userId: userId)
            
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpg"
            
            StorageService.saveProfileImage(userId: userId, username: username, email: email, imageData: imageData, metaData: metaData, storageProfileImageRef: storageProfileUserId, onSuccess: onSuccess, onError: onError)
        }
    }
    
    static func signIn(email: String, password: String, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) {
            (authData, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            guard let userId = authData?.user.uid else {
                return
            }
            
            let firestoreUserId = getUserId(userId: userId)
            
            firestoreUserId.getDocument {
                (document, error) in
                if let dict = document?.data() {
                    guard let decodedUser = try? User.init(fromDictionary: dict) else {
                        return
                    }
                    onSuccess(decodedUser)
                }
            }
        }
    }
    
    static func changePassword(password: String, newPassword: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        if let email = Auth.auth().currentUser!.email {
            Auth.auth().signIn(withEmail: email, password: password) {
                (authData, error) in
                if error != nil {
                    onError(error!.localizedDescription)
                    return
                }
                
                Auth.auth().currentUser?.updatePassword(to: newPassword) {
                    error in
                    if error != nil {
                        onError(error!.localizedDescription)
                        return
                    }
                    
                    onSuccess()
                }
            }
        }
    }
    
    static func forgotPassword(email: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        print(email)
        Auth.auth().sendPasswordReset(withEmail: email) {
            error in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            onSuccess()
        }
    }
    
}
