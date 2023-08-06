//
//  NoteDetailView.swift
//  TaiNguyen-Notes
//
//  Created by Tai Nguyen on 06/08/2023.
//

import SwiftUI

struct NoteDetailView: View {
    @EnvironmentObject var myNote: NoteViewModel
    var note: Note
    @State var isPinned = false
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(note.name)
                .font(.largeTitle)
                .bold()
            Text(note.content)
            Spacer()
        }
        .padding()
        .frame(width: myWidth, alignment: .leading)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    Note.addData(note: note)
                    isPinned.toggle()
                    if !isPinned {
                        if let itemToRemoveIndex = myNote.pinnedNote.firstIndex(of: note) {
                            myNote.pinnedNote.remove(at: itemToRemoveIndex)
                        }
                    } else {
                        myNote.pinnedNote.append(note)
                    }
                } label: {
                    if isPinned {
                        Image(systemName: "pin.fill")
                    } else {
                        Image(systemName: "pin")
                    }
                }
            }
        }
        .onAppear {
            if Note.readData().contains(note) {
                isPinned = true
            } else {
                isPinned = false
            }
        }
        .navigationTitle("Note Detail")
    }
}

struct NoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NoteDetailView(note: Note(name: "Name Note", content: "Note content"))
    }
}
