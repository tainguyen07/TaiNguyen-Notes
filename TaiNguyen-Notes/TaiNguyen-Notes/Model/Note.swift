//
//  Note.swift
//  TaiNguyen-Notes
//
//  Created by Tai Nguyen on 06/08/2023.
//

import Foundation
import UIKit

struct Note: Identifiable, Hashable, Codable {
    var id = UUID().uuidString
    var name: String
    var content: String
    static func readData() -> [Note] {
        if let data = UserDefaults.standard.data(forKey: myPinnedNotes) {
            do {
                let decoder = JSONDecoder()
                let notes = try decoder.decode([Note].self, from: data)
                return notes
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
        return []
    }
    static func addData(note: Note) {
        var notes = readData()
        if notes.contains(note) {
            //Unpin
            if let itemToRemoveIndex = notes.firstIndex(of: note) {
                notes.remove(at: itemToRemoveIndex)
            }
        } else {
            notes.append(note)
        }
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(notes)
            UserDefaults.standard.set(data, forKey: myPinnedNotes)
        } catch {
            print("Unable to Encode Array of Notes (\(error))")
        }
    }
}
