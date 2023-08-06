//
//  NoteDetailView.swift
//  TaiNguyen-Notes
//
//  Created by Tai Nguyen on 06/08/2023.
//

import SwiftUI

struct NoteDetailView: View {
    var note: Note
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
                    
                } label: {
                    Image(systemName: "pin")
                }
                
            }
        }
    }
}

struct NoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NoteDetailView(note: Note(name: "Name Note", content: "Note content", username: "xxx"))
    }
}
