//
//  ContentView.swift
//  TaiNguyen-Notes
//
//  Created by Tai Nguyen on 03/08/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var myNotes: MyNote
    @State var isShowingPopover = false
    var body: some View {
        TabView {
            ZStack {
                NavigationView {
                    List {
                        Section(header: Text("Pinned")
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)) {
                                ForEach(myNotes.notes, id: \.self) { note in
                                    NoteCell(name: note.name, content: note.content)
                                }
                                .onDelete { indexSet in
                                    myNotes.notes.remove(atOffsets: indexSet)
                                }
                            }
                            .textCase(nil)
                        Section(header: Text("Others")
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)) {
                                ForEach(myNotes.notes, id: \.self) { note in
                                    NoteCell(name: note.name, content: note.content)
                                }
                            }
                            .textCase(nil)
                    }
                    .listStyle(InsetGroupedListStyle())
                    .navigationTitle("Notes")
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            Button {
                                isShowingPopover.toggle()
                            } label: {
                                Image(systemName: "square.and.pencil")
                            }
                            
                        }
                    }
                }
                if isShowingPopover {
                    NewNoteView(myNotes: myNotes, isShowingPopover: $isShowingPopover)
                }
            }
            .tabItem {
                Label("Notes",systemImage: "list.dash")
            }
            
            ProfileView()
            .tabItem {
                Label("Profile",systemImage: "person.crop.circle")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let myNote = MyNote()
        myNote.notes = testNotes
        return ContentView(myNotes: myNote)
    }
}

struct NoteCell: View {
    var name: String
    var content: String
    var body: some View {
        HStack {
            Image(systemName: "note.text")
            VStack(alignment: .leading) {
                Text(name)
                Text(content)
            }
        }
    }
}

struct NewNoteView: View {
    @ObservedObject var myNotes: MyNote
    @Binding var isShowingPopover: Bool
    
    init(myNotes: MyNote, isShowingPopover: Binding<Bool>) {
        self.myNotes = myNotes
        self._isShowingPopover = isShowingPopover
    }
    @State var newNoteName = ""
    @State var newNoteContent = ""
    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                    .fill(Color(.systemGray4))
                    .frame(width: geo.size.width*0.7,height: geo.size.width*0.5, alignment: .center)
                VStack {
                    Text("New Note")
                        .font(.headline)
                    Spacer()
                    TextField("Name", text: $newNoteName)
                        .frame(width: 200, height: 10)
                        .padding()
                        .background(Color(.white))
                        .cornerRadius(7)
                    TextField("Content", text: $newNoteContent)
                        .frame(width: 200, height: 10)
                        .padding()
                        .background(Color(.white))
                        .cornerRadius(7)
                    Spacer()
                    Color.gray.frame(width: 200, height: 0.5)
                    HStack {
                        Button("Cancel") {
                            print("Cancel")
                            isShowingPopover.toggle()
                        }.frame(maxWidth: .infinity)
                        Button {
                            myNotes.notes.append(Note(name: newNoteName, content: newNoteContent))
                            isShowingPopover.toggle()
                        } label: {
                            Text("Save")
                                .frame(maxWidth: .infinity)
                        }

                        
                    }
                }
                .frame(width: geo.size.width*0.7, height: geo.size.width*0.35)
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
    }
}
