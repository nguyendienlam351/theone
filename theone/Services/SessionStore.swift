//
//  SessionStore.swift
//  theone
//
//  Created by nguyenlam on 5/1/22.
//

import Foundation
import Combine
import Firebase
import FirebaseAuth

class SessionStore: ObservableObject {
    // MARK: Properties
    var didChange = PassthroughSubject<SessionStore, Never>()
    @Published var session: User? {
        didSet{
            self.didChange.send(self)
        }
    }
    var handle: AuthStateDidChangeListenerHandle?
    
    // MARK: Merthod
    func listen() {
        handle = Auth.auth().addStateDidChangeListener({
            (auth, user) in
            if let user = user {
                let firestoreUserId = AuthService.getUserId(userId: user.uid)
                firestoreUserId.getDocument {
                    (document, error) in
                    if let dict = document?.data() {
                        guard let decodedUser = try? User.init(fromDictionary: dict) else {
                            return
                        }
                        self.session = decodedUser
                    }
                }
            }
            else {
                self.session = nil
            }
        })
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            
        }
    }
    
    func umbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit {
        umbind()
    }
}
