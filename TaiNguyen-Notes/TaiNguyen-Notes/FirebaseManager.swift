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
    
    func observeTasks(completion: @escaping ([Note]) -> Void) {
        databaseRef.child("notes").observe(.value) { snapshot in
            var notes: [Note] = []
            for childSnapshot in snapshot.children {
                if let childSnapshot = childSnapshot as? DataSnapshot,
                   let taskDict = childSnapshot.value as? [String: Any],
                   let id = taskDict["id"] as? String,
                   let name = taskDict["name"] as? String,
                   let content = taskDict["content"] as? String,
                   let username = taskDict["username"] as? String,
                   let uuidDevice = taskDict["uuidDevice"] as? String {
                    let note = Note(id: id,name: name, content: content, username: username,uuidDevice: uuidDevice)
                    notes.append(note)
                }
            }
            completion(notes)
        }
    }
    
    func addTask(note: Note) {
        let taskData: [String: Any] = [
            "id" : note.id,
            "name" : note.name,
            "content" : note.content,
            "username" : note.username,
            "uuidDevice" : note.uuidDevice ?? ""
        ]
        let newTaskRef = databaseRef.child("notes").childByAutoId()
        newTaskRef.setValue(taskData)
    }
}
