//
//  AddWordView.swift
//  Vocab
//
//  Created by Michael Perkins on 6/20/25.
//

import SwiftUI

struct MainView: View {
    // State variable to hold current search variable
    @State private var vocabWord: String = ""
    @State private var resultWord: WordEntry? = nil
    // Access the shared Dictionary via @EnvironmentObject
    @EnvironmentObject var dictionaryManager: DictionaryManager
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    // TextField: vocab search
                    TextField("Search for a vocabulary word", text: $vocabWord)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    // Button: for fetching word from api and saving word and info to dictionary
                    Button("Search") {
                        // TODO: ensure input is a valid word
                        
                        // call api to search for it
                        let apiService = DictionaryAPIService()
                        Task {
                            do {
                                let fetchedWord = try await apiService.fetchWord(for: vocabWord)
                                
                                // add word to Core Data dictionary
                                resultWord = dictionaryManager.addWord(word: fetchedWord.meta.id, partOfSpeech: fetchedWord.fl, definitions: fetchedWord.shortdef)

                            } catch {
                                print("API error:", error)
                                resultWord = nil
                            }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
                
                // TODO: display word and definition/info, OR message indicating it was not found
                VStack(alignment: .leading) {
                    Text(resultWord?.word ?? "")
                        .font(.headline)
                    Text(resultWord?.partOfSpeech ?? "")
                        .italic()
                    if let definitions = resultWord?.definitions as? [String] {
                        ForEach(definitions, id: \.self) { def in
                            Text(def)
                                .font(.body)
                                .padding(.bottom, 2)
                        }
                    }
                }
                
            }
            .navigationTitle("Vocab App")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        
        MainView()
            .environmentObject(DictionaryManager(context: context))
            .environment(\.managedObjectContext, context)
    }
}
