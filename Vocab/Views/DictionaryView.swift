//
//  WordListView.swift
//  Vocab
//
//  Created by Michael Perkins on 6/20/25.
//

import SwiftUI

struct DictionaryView: View {
    @EnvironmentObject var dictionary: Dictionary
    
    var body: some View {
        NavigationView {
            VStack {
                List(dictionary.vocabList) { entry in
                    VStack(alignment: .leading) {
                        Text(entry.word)
                            .font(.largeTitle)
                        Text(entry.partOfSpeech)
                            .italic()
                        ForEach(entry.definitions, id: \.self) { def in
                            Text(def)
                                .font(.subheadline)
                        }
                    }
                    
                }
                
                Spacer()
                
            }
            .navigationTitle("My Dictionary")
        }
    }
}

struct DictionaryPreviews: PreviewProvider {
    static var previews: some View {
        DictionaryView()
            .environmentObject(Dictionary())
    }
}
