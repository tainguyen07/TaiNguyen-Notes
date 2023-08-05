//
//  TaiNguyen_NotesApp.swift
//  TaiNguyen-Notes
//
//  Created by Tai Nguyen on 03/08/2023.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct TaiNguyen_NotesApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var myNote = MyNote()
    var body: some Scene {
        WindowGroup {
            ContentView(myNotes: myNote)
        }
    }
}
