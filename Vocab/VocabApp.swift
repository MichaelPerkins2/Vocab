//
//  VocabApp.swift
//  Vocab
//
//  Created by Michael Perkins on 1/27/25.
//

import SwiftUI

@main
struct VocabApp: App {

    var dictionaryManager = DictionaryManager(context: PersistenceController.shared.container.viewContext)
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(dictionaryManager)
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        }
    }
}


