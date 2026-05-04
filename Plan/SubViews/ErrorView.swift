//
//  ErrorView.swift
//  Plan
//
//  Created by Fede Garcia on 04/05/2026.
//

import SwiftUI

struct ErrorView: View {
    var error: String
    var reload: () -> Void
    
    var body: some View {
        Text("we had an error: \(error)")
        Button("Try Again") {
            reload()
        }
    }
}

#Preview {
    ErrorView(error: "Error 1") {}
}
