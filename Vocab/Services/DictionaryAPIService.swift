//
//  DictionaryAPIService.swift
//  Vocab
//
//  Created by Michael Perkins on 6/24/25.
//

import Foundation

class DictionaryAPIService {
    
    func fetchWord(for word: String) async throws -> WordEntry {
        guard let apiKeyPath = Bundle.main.path(forResource: "Secrets", ofType: "plist") else {
            fatalError("Could not find file 'Secrets.plist'")
        }
        let plist = NSDictionary(contentsOfFile: apiKeyPath)
        guard let apiKey = plist?.object(forKey: "MERRIAM_WEBSTER_API_KEY") as? String else {
            fatalError("Could not find key 'MERRIAM_WEBSTER_API_KEY'")
        }
        
        
        let apiEndpoint = "https://www.dictionaryapi.com/api/v3/references/collegiate/json/\(word)?key=\(apiKey)"
        guard let urlEndpoint = URL(string: apiEndpoint) else {
            throw URLError(.badURL)
        }
        

        let (data, _) = try await URLSession.shared.data(from: urlEndpoint)
        
        let decodedData = try JSONDecoder().decode([APIResponse].self, from: data)
        
        guard let first = decodedData.first else {
            throw NSError(domain: "No entries found", code: 0)
        }
        
        return WordEntry(
            word: first.meta.id,
            definitions: first.shortdef,
            partOfSpeech: first.fl,
            dateAdded: Date(),
            memorized: false
        )
    }
    
    struct APIResponse: Decodable {
        let meta : Meta
        let fl : String
        let shortdef : [String]
    }
    
    struct Meta: Decodable {
        let id: String
    }
}
