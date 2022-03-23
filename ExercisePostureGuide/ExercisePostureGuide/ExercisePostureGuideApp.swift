//
//  ExercisePostureGuideApp.swift
//  ExercisePostureGuide
//
//  Created by 박광이 on 2022/03/17.
//

import SwiftUI
import Firebase

@main
struct ExercisePostureGuideApp: App {
    
    //@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var appState = Appstate()
    
    init() {
            FirebaseApp.configure()
        }

    var body: some Scene {
        WindowGroup {
            if appState.isLoggedIn{
                // show tab view
                TabContainerView()
            } else{
            LandingView()
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("setting up firebase")
        FirebaseApp.configure()
        return true
    }
}

class Appstate: ObservableObject{
    @Published private(set) var isLoggedIn = false
    
    private let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol = UserService()){
        self.userService = userService
        try? Auth.auth().signOut()
        userService.observeAuthChanges()
            .map { $0 != nil }
            .assign(to: &$isLoggedIn)
    }
}
