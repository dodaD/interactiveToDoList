//
//  Task.swift
//  InteractiveToDoList
//
//  Created by Doda Diana on 23.04.2025.
//

import Foundation


struct Task: Hashable, Codable, Identifiable {
    var id: Int
    var task: String
    var state: Bool
    var description: String
    var date: String
}
