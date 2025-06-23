//
//  VocabApp.swift
//  Vocab
//
//  Created by Michael Perkins on 1/27/25.
//

import SwiftUI

@main
struct VocabApp: App {
    var dictionary = Dictionary()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(dictionary)
        }
    }
}


