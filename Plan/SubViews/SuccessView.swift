//
//  SuccessView.swift
//  Plan
//
//  Created by Fede Garcia on 04/05/2026.
//

import SwiftUI

struct SuccessView: View {
    
    var users: [User]

    
    var body: some View {
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
                                        VStack {
                                            Text(user.name)
                                                .font(.title3.bold())
                                                .foregroundStyle(.primary)
                                            Text(user.email)
                                                .foregroundStyle(.secondary)
                                        }
                                        .frame(height: 55)
                                        .foregroundStyle(.white)
                                    }
                                    .clipShape(.capsule)
                                }

                            }
                        }
                    }
                    
                
            }
            .padding()
            .navigationTitle("Users")
    }
}

