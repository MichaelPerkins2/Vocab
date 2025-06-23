//
//  WordEntry.swift
//  Vocab
//
//  Created by Michael Perkins on 6/20/25.
//

import Foundation

struct WordEntry: Identifiable {
    var id = UUID()
    var word : String
    var definitions : [String]
    var partOfSpeech : String
    var dateAdded : Date
    var memorized : Bool
}

class Dictionary: ObservableObject {
    @Published var vocabList: [WordEntry] = []
    
    func addWord(wordEntry : WordEntry) {
        // check if word already exists in dictionary
        if !vocabList.contains(where: {$0.word.lowercased() == wordEntry.word.lowercased() }) {
            
            vocabList.append(wordEntry)
        }
    }
    
    func deleteWord(){}
    func editWord(){}
}

class DictionaryAPIService {
    // todo: create environment variable for api key?
    let apiKey = ""
    
    func fetchWord(for word: String) async throws -> WordEntry {
        var apiEndpoint = "https://www.dictionaryapi.com/api/v3/references/collegiate/json/\(word)?key=\(apiKey)"
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
