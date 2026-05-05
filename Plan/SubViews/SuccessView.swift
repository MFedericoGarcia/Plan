//
//  SuccessView.swift
//  Plan
//
//  Created by Fede Garcia on 04/05/2026.
//

import SwiftUI

struct SuccessView: View {
    
    var users: [User]
    @State private var searchText = ""
    
    var body: some View {
            VStack {
                
                    ScrollView {
                        VStack {
                            ForEach(users, id: \.id){ user in
                                if searchText.isEmpty {
                                        SuccessFilteredView(user: user)
                                } else {
                                    if user.name.localizedStandardContains(searchText) {
                                        SuccessFilteredView(user: user)
                                    }
                                }
                            }
                            .searchable(text: $searchText, placement: .navigationBarDrawer,  prompt: "Buscar por nombre")
                        }
                    }
                    
                
            }
            .padding()
            .navigationTitle("Users")
    }
}

