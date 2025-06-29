//
//  ProfileView.swift
//  Vocab
//
//  Created by Michael Perkins on 6/24/25.
//

import SwiftUI

struct ProfileView: View {
    @State private var darkMode: Bool = false // TODO: connect to environment or settings bundle
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text ("Preferences")) {
                    Toggle("Dark Mode", isOn: $darkMode)
                }
                Section(header: Text("Settings")) {
                    HStack {
                        Text("Username")    // TODO: display username, email, password next to these fields
                        Spacer()
                        Text("JohnDoe123")
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("Email")
                        Spacer()
                        Text("\("johndoe@example.com")")
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("Password")
                        Spacer()
                        Text("Password123")
                            .foregroundColor(.gray)
                            .monospaced()
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
