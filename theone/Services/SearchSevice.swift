//
//  SearchSevice.swift
//  theone
//
//  Created by nguyennam on 5/10/22.
//

import Foundation
import FirebaseAuth

class SearchSevice {
    // MARK: Merthod
    static func searchUser(input: String, onSusscess: @escaping (_ user: [User]) -> Void) {
        if input.isEmpty {
            onSusscess([User]())
            return
        }
        
        let name = input.lowercased()
                
        AuthService.storeRoot.collection("users").whereField("username", isGreaterThanOrEqualTo: name).whereField("username", isLessThanOrEqualTo: name+"\u{F7FF}").getDocuments {
            (querySnapshot, err) in
            
            guard let snap = querySnapshot else {
                print("error")
                return
            }
            
            var users = [User]()
            for document in snap.documents {
                let dict = document.data()
                
                guard let decoded = try? User.init(fromDictionary: dict) else {
                    return
                }
                
                if decoded.uid != Auth.auth().currentUser?.uid {
                    users.append(decoded)
                }
                
                onSusscess(users)
            }
            
        }
    }
}
