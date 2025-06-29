//
//  Dictionary.swift
//  Vocab
//
//  Created by Michael Perkins on 6/24/25.
//

import Foundation
import CoreData

class DictionaryManager: ObservableObject {
    let viewContext: NSManagedObjectContext
    init(context: NSManagedObjectContext) {
        self.viewContext = context
    }
    
    // get all word entries from user's dictionary
//    func getAll() -> [WordEntry] {
//        let results: [WordEntry]
//
//        do {
//            let request = NSFetchRequest<WordEntry>(entityName: "WordEntry")
//
//            results = try viewContext.fetch(request)
//
//            return results
//
//        } catch {
//            print(error)
//        }
//
//        return results
//    }
    
    // add valid word to user's dictionary
    func addWord(word : String, partOfSpeech: String, definitions: [String]) -> WordEntry? {
        do {
            let request = NSFetchRequest<WordEntry>(entityName: "WordEntry")
            request.predicate = NSPredicate(format: "word =[c] %@", word)
            
            let existingWord = try viewContext.fetch(request)
            
            // check if word already exists in dictionary
            if existingWord.isEmpty {
                let newEntry = WordEntry(context: viewContext)
                newEntry.word = word
                newEntry.partOfSpeech = partOfSpeech
                newEntry.definitions = definitions as NSArray
                newEntry.dateAdded = Date()
                newEntry.memorized = false
                
                try viewContext.save()
                return newEntry
                
            } else {
                return existingWord.first
            }
        } catch {
            print(error)
            return nil
        }
    }
    
    func deleteWord(){}
    func editWord(){}
}
