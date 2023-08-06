//
//  FirebaseManager.swift
//  TaiNguyen-Notes
//
//  Created by Tai Nguyen on 06/08/2023.
//

import Foundation
import Firebase
import FirebaseDatabase

class FirebaseManager {
    static let shared = FirebaseManager()
    
    private let databaseRef = Database.database().reference()
    
    func observeNotes(completion: @escaping ([Note]) -> Void) {
        databaseRef.child(myNotes).observe(.value) { snapshot in
            var notes: [Note] = []
            for childSnapshot in snapshot.children {
                if let childSnapshot = childSnapshot as? DataSnapshot,
                   let taskDict = childSnapshot.value as? [String: Any],
                   let name = taskDict["name"] as? String,
                   let content = taskDict["content"] as? String {
                    let id = childSnapshot.key
                    let note = Note(id: id,name: name, content: content)
                    notes.append(note)
                }
            }
            completion(notes)
        }
    }
    
    func addNote(note: Note) {
        let taskData: [String: Any] = [
            "id" : note.id,
            "name" : note.name,
            "content" : note.content
        ]
        let newTaskRef = databaseRef.child(myNotes).childByAutoId()
        newTaskRef.setValue(taskData)
    }
    
    func deleteNote(withID id: String) {
        let taskRef = databaseRef.child(myNotes).child(id)
        taskRef.removeValue()
    }
}
