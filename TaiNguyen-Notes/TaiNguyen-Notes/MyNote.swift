//
//  MyNote.swift
//  TaiNguyen-Notes
//
//  Created by Tai Nguyen on 05/08/2023.
//

import Foundation

class MyNote: ObservableObject {
    @Published var notes = [Note]()
}

struct Note: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var content: String
}

var testNotes = [
    Note(name: "Note1", content: "Test content 1"),
    Note(name: "Note2", content: "Test content 2")
]
