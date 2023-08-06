//
//  ContentView.swift
//  TaiNguyen-Notes
//
//  Created by Tai Nguyen on 03/08/2023.
//

import SwiftUI
import FirebaseDatabase
struct ContentView: View {
    var body: some View {
        TabView {
            NotesView()
            .tabItem {
                Label("Notes",systemImage: "list.dash")
            }
            
            ProfileView()
            .tabItem {
                Label("Profile",systemImage: "person.crop.circle")
            }
        }
        .environmentObject(NoteViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
