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
    
    func getSpells(completion: @escaping ([String]) -> Void) {
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data else { return }
                
                do {
                    // Декодируем данные
                    let spellsData = try JSONDecoder().decode(SpellsData.self, from: data)
                    
                    // Извлекаем массив заклинаний
                    let incantations = spellsData.compactMap { $0.incantation }
                    
                    // Передаем массив строк в completion
                    completion(incantations)
                } catch {
                    print("Ошибка декодирования: \(error)")
                }
            }
        task.resume()
    }
}
