//
//  LoadingView.swift
//  Plan
//
//  Created by Fede Garcia on 04/05/2026.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack{
            
            ProgressView()
                .progressViewStyle(.circular)
                .scaleEffect(5)
                .padding(50)

            
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.largeTitle.bold())
                Text("Loading...")
                    .font(.title.bold())
            }
            .foregroundStyle(.secondary)
            
        }
    }
}

#Preview {
    LoadingView()
}
