//
//  SuccessFilteredView.swift
//  Plan
//
//  Created by Fede Garcia on 05/05/2026.
//

import SwiftUI

struct SuccessFilteredView: View {
    var user: User
    var body: some View {
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

