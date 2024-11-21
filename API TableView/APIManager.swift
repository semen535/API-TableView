//
//  APIManager.swift
//  API TableView
//
//  Created by Семен Гевенов on 18.11.2024.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    
    let urlString = "https://wizard-world-api.herokuapp.com/Spells"
    
    func getSpells(completion: @escaping ([SpellsDatum]) -> Void) {
        guard let url = URL(string: "https://wizard-world-api.herokuapp.com/Spells") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let spells = try JSONDecoder().decode(SpellsData.self, from: data)
                completion(spells)
            } catch {
                print("Ошибка декодирования: \(error)")
                completion([])
            }
        }.resume()
    }
}
