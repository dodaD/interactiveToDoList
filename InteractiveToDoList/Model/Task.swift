//
//  Task.swift
//  InteractiveToDoList
//
//  Created by Doda Diana on 23.04.2025.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers


/*struct Task: Hashable, Codable, Identifiable, Transferable{
    var id: Int
    var task: String
    var state: Bool
    var description: String
    var date: String
    
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .task)
    }
}

extension UTType {
    static var task: UTType {
        UTType(exportedAs: "interactive-to-do-list.task")
    }
}*/

class Task: Identifiable, Decodable {
    public var id: Int = 0
    public var task: String = ""
    public var state: Bool = false
    public var description: String = ""
    public var date: String = ""
}
