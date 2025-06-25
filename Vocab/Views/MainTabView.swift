//
//  TabView.swift
//  Vocab
//
//  Created by Michael Perkins on 6/24/25.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var dictionary: Dictionary
    
    @State private var selectedTab = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // TODO: fix later for newer versions of xcode/ios
            DictionaryView()
                .tabItem {
                    Image(systemName: "book.closed.fill")
                    Text("Dictionary")
                }
                .tag(0)
            MainView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(1)
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Profile")
                }
                .tag(2)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
