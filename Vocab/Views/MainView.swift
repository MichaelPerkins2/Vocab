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
    @EnvironmentObject var dictionary: Dictionary
    
    var body: some View {
        NavigationView {
            VStack {
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
                            let fetched = try await apiService.fetchWord(for: vocabWord)
                            dictionary.addWord(wordEntry: fetched)
                            resultWord = fetched
                        } catch {
                            print("API error:", error)
                            resultWord = nil
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
                
                // TODO: display word and definition/info, or message indicating it was not found
                if let word = resultWord {
                    VStack(alignment: .leading) {
                        Text(word.word)
                            .font(.largeTitle)
                        Text(word.partOfSpeech)
                            .italic()
                        ForEach(word.definitions, id: \.self) { def in
                            Text(def)
                                .font(.body)
                                .padding(.bottom, 2)
                        }
                    }
                    .padding()
                }
                
                Spacer()
                
                // NavigationLink or Button to DictionaryView
                NavigationLink(destination: DictionaryView()) {
                    Text("Go to Dictionary")
                }
                .padding()
                
            }
            .navigationTitle("Vocabulary Builder")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(Dictionary())
    }
}
