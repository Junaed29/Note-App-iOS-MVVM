//
//  Note.swift
//  Notes_iOS
//
//  Created by Junaed Muhammad Chowdhury on 10/5/23.
//

import Foundation


struct Note: Codable, Identifiable {
    let id: String?
    let noteValue: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case noteValue = "note"
    }
}
