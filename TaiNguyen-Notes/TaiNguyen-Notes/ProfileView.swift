//
//  ProfileView.swift
//  TaiNguyen-Notes
//
//  Created by Tai Nguyen on 05/08/2023.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var myNotes: MyNote
    @State private var username = ""
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Username")
                        .bold()
                    TextField(myAnonymous, text: $username)
                        .frame(width: 200, height: 10)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(7)
                        .submitLabel(.done)
                        .onSubmit {
                            UserDefaults.standard.set(self.username, forKey: myUsername)
                        }
                }
                Spacer()
                List {
                    Section("My notes") {
                        ForEach(myNotes.notes, id: \.self) { note in
                            NoteCell(name: note.name, content: note.content)
                        }
                        .onDelete { indexSet in
                            myNotes.notes.remove(atOffsets: indexSet)
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("Profile")
        }
        .onAppear {
            if let username = UserDefaults.standard.string(forKey: myUsername) {
                self.username = username
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(MyNote())
    }
}
