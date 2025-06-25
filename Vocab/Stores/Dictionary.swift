//
//  Dictionary.swift
//  Vocab
//
//  Created by Michael Perkins on 6/24/25.
//

import Foundation

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
