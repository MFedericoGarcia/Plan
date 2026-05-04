//
//  ContentView.swift
//  Plan
//
//  Created by Fede Garcia on 04/05/2026.
//

import SwiftUI

struct UsersView: View {
    
    @State private var users = [User]()
    
    var body: some View {
        VStack {
            List {
                ForEach(users, id: \.id){ user in
                    HStack {
                        Text(user.name)
                        Text(user.email)
                    }
                }
            }
        }
        .onAppear {
            Task {
                NetworkManager.shared.getUsers(for: Endpoints.user) { users, error in
                    self.users = users ?? []
                    if let error = error {
                        print(error)
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    UsersView()
}
