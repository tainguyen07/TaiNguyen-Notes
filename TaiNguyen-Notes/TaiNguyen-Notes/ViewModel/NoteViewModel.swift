//
//  MyNote.swift
//  TaiNguyen-Notes
//
//  Created by Tai Nguyen on 05/08/2023.
//

import Foundation

class NoteViewModel: ObservableObject {
    @Published var notes: [Note] = []
}
