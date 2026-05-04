//
//  ContentView.swift
//  Plan
//
//  Created by Fede Garcia on 04/05/2026.
//

import SwiftUI

struct UsersView: View {
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                LoadingView()
            case .success(let users):
                NavigationStack {
                    SuccessView(users: users)
                }
            case .error(let error):
                ErrorView(error: error) {
                    viewModel.reload()
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}


#Preview {
    UsersView()
}
