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
        ZStack {
            
            NavigationStack {
                
                VStack {
                    
                        ScrollView {
                            VStack {
                                ForEach(users, id: \.id){ user in
                                    NavigationLink {
                                        UserDetailView(user: user)
                                    } label: {
                                        ZStack {
                                            LinearGradient(colors: [.blue, .black] , startPoint: .topLeading, endPoint: .bottomTrailing)
                                                .ignoresSafeArea()
                                            HStack {
                                                Text(user.name)
                                                Text(user.email)
                                            }
                                            .frame(width: .infinity, height: 55)
                                            .foregroundStyle(.white)
                                        }
                                        .clipShape(.capsule)
                                    }

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
                .navigationTitle("Users")
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    UsersView()
}
