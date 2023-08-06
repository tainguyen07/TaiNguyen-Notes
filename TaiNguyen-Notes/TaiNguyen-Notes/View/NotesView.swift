//
//  NotesView.swift
//  TaiNguyen-Notes
//
//  Created by Tai Nguyen on 05/08/2023.
//

import SwiftUI

struct NotesView: View {
    @EnvironmentObject var myNotes: NoteViewModel
    @State var isShowingPopover = false
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    Section(header: Text("Pinned")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)) {
                            ForEach(myNotes.notes, id: \.self) { note in
                                NoteCell(note: note)
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
                                NoteCell(note: note)
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
                NewNoteView(isShowingPopover: $isShowingPopover)
            }
        }
        .onAppear {
            FirebaseManager.shared.observeTasks { observedTasks in
                myNotes.notes = observedTasks
            }
        }
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
            .environmentObject(NoteViewModel())
    }
}

struct NoteCell: View {
    var note: Note
    var body: some View {
        NavigationLink {
            NoteDetailView(note: note)
        } label: {
            HStack {
                Image(systemName: "note.text")
                VStack(alignment: .leading) {
                    Text(note.name)
                    Text(note.content)
                }
            }
        }
    }
}

struct NewNoteView: View {
    @EnvironmentObject var myNotes: NoteViewModel
    @Binding var isShowingPopover: Bool
    
    init(isShowingPopover: Binding<Bool>) {
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
                            let note = Note(name: newNoteName, content: newNoteContent, username: "")
                            myNotes.notes.append(note)
                            FirebaseManager.shared.addTask(note: note)

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
