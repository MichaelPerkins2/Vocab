//
//  WordListView.swift
//  Vocab
//
//  Created by Michael Perkins on 6/20/25.
//

import SwiftUI

struct DictionaryView: View {
    @EnvironmentObject var dictionaryManager: DictionaryManager
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \WordEntry.dateAdded, ascending: false)],
        animation: .default
    ) var words: FetchedResults<WordEntry>
    
    var body: some View {
        NavigationView {
            VStack {
                
                if words.isEmpty{
                    Text("Added words will be displayed here")
                }

                List {
                    ForEach(words) { entry in
                        VStack(alignment: .leading) {
                            Text(entry.word ?? "")
                                .font(.headline)
                            Text(entry.partOfSpeech ?? "")
                                .italic()
                            if let definitions = entry.definitions as? [String] {
                                ForEach(definitions, id: \.self) { def in
                                    Text(def)
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                    .onDelete(perform: delete)
                }
                
                // Temporary--for testing Core Data
                .onAppear {
                    print("💾 WORD COUNT: \(words.count)")
                    for word in words {
                        print("🟢", word.word ?? "nil")
                        print("-", word.id ?? "nil")
                        print("-", word.partOfSpeech ?? "nil")
                        print("-", word.memorized)
                    }
                }

                Spacer()
            }
            .navigationTitle("My Dictionary")
            
        }
    }
    
    func delete(at offsets: IndexSet) {
        for index in offsets {
            let word = words[index]
            dictionaryManager.deleteWord(word: word)
        }
    }
}



struct DictionaryPreviews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        
        MainView()
            .environmentObject(DictionaryManager(context: context))
            .environment(\.managedObjectContext, context)
    }
}



