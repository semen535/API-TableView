//
//  SpellsData.swift
//  API TableView
//
//  Created by Семен Гевенов on 18.11.2024.
//

import Foundation

// MARK: - SpellsDatum
struct SpellsDatum: Decodable {
    let id, name: String
    let incantation: String?
    let effect: String
    let canBeVerbal: Bool?
    let type, light: String
    let creator: String?
}

typealias SpellsData = [SpellsDatum]
