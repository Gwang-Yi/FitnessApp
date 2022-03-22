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
    
    init() {
            FirebaseApp.configure()
        }

    var body: some Scene {
        WindowGroup {
            LandingView()
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
