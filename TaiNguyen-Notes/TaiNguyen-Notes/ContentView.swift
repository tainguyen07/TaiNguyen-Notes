//
//  ContentView.swift
//  TaiNguyen-Notes
//
//  Created by Tai Nguyen on 03/08/2023.
//

import SwiftUI

struct ContentView: View {
    var notes = ["Note1", "Note2"]
    @State var isShowingPopover = false
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    Section(header: Text("Pinned")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)) {
                            ForEach(notes, id: \.self) { noteName in
                                NoteCell(name: noteName)
                            }
                        }
                        .textCase(nil)
                    Section(header: Text("Upcoming")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)) {
                            ForEach(notes, id: \.self) { noteName in
                                NoteCell(name: noteName)
                            }
                        }
                        .textCase(nil)
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("Note")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button {
                            
                        } label: {
                            Image(systemName: "person.circle")
                        }

                    }
                    ToolbarItemGroup(placement: .bottomBar) {
                        Image(systemName: "folder.badge.plus")
                            .onTapGesture {
                                isShowingPopover.toggle()
                            }
                        Image(systemName: "square.and.pencil")
                    }
                    
                }
            }
            if isShowingPopover {
                NewNoteView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct NoteCell: View {
    var name: String
    var body: some View {
        HStack {
            Image(systemName: "note.text")
            Text(name)
        }
    }
}

struct NewNoteView: View {
    @State var newNoteName = ""
    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                    .fill(Color(.systemGray4))
                    .frame(width: geo.size.width*0.7,height: geo.size.width*0.4, alignment: .center)
                VStack {
                    Text("New Note")
                        .font(.headline)
                    Text("Enter a name for this note")
                        .font(.subheadline)
//                    Spacer()
                    TextField("Name", text: $newNoteName)
                        .frame(width: 200, height: 10)
                        .padding()
                        .background(Color(.white))
                        .cornerRadius(7)
//                    Spacer()
                    Color.gray.frame(width: 200, height: 1)
                    HStack {
                        Button("Cancel") {
                            print("Cancel")
                        }.frame(maxWidth: .infinity)
                        Button("Save") {
                            print("Save")
                        }.frame(maxWidth: .infinity)
                    }
                }
                .frame(width: geo.size.width*0.7, height: geo.size.width*0.35)
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
    }
}
