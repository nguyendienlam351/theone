//
//  theoneApp.swift
//  theone
//
//  Created by nguyenlam on 4/28/22.
//

import SwiftUI
import Firebase

@main
struct theoneApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            SignInView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        print("Firebase...")
        
        FirebaseApp.configure()
        return true
    }
}
