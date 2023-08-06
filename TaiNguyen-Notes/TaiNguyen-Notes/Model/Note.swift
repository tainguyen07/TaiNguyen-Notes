//
//  Note.swift
//  TaiNguyen-Notes
//
//  Created by Tai Nguyen on 06/08/2023.
//

import Foundation
import UIKit

struct Note: Identifiable, Hashable {
    var id = UUID().uuidString
    var name: String
    var content: String
    var username: String
    var uuidDevice = UIDevice.current.identifierForVendor?.uuidString
}
