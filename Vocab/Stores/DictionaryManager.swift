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
    func addWord(word : String, partOfSpeech: String, definitions: [String]) {
        do {
            let request = NSFetchRequest<WordEntry>(entityName: "WordEntry")
            request.predicate = NSPredicate(format: "word =[c] %@", word)
            
            let existingWord = try viewContext.fetch(request)
            
            // check if word already exists in dictionary
            if existingWord.isEmpty {
                let newEntry = WordEntry(context: viewContext)
                newEntry.id = UUID()
                newEntry.word = word
                newEntry.partOfSpeech = partOfSpeech
                newEntry.definitions = definitions as NSArray
                newEntry.dateAdded = Date()
                newEntry.memorized = false
                
                try viewContext.save()
//                return newEntry
                
            } else {
//                return existingWord.first
            }
        } catch {
            print(error)
//            return nil
        }
    }
    
    func deleteWord(word : WordEntry) {
        do {
            viewContext.delete(word)
            
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    func editWord(){}
    func clearDictionary(){
        do {
            // fetch all WordEntry objects (for use in the delete)
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "WordEntry")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            deleteRequest.resultType = .resultTypeObjectIDs
            
            // execute delete
            let batchDelete = try viewContext.execute(deleteRequest) as? NSBatchDeleteResult
            
            // update SwiftUI to reflect the deletion
            guard let deleteResult = batchDelete?.result as? [NSManagedObjectID] else { fatalError("Unexpected result type.") }
            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: [NSDeletedObjectsKey : deleteResult], into: [viewContext])
            
        } catch {
            print(error)
        }
    }
}
