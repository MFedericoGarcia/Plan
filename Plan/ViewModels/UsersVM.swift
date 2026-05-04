//
//  UsersVM.swift
//  Plan
//
//  Created by Fede Garcia on 04/05/2026.
//

import Foundation

extension UsersView {
    @Observable
    class ViewModel {
        
        enum States {
            case loading
            case success([User])
            case error(String)
        }
          
        var state: States = .loading
        
        
        init(users: [User]? = nil) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.load()
            }
        }
        
        func load() {
            Task { @MainActor in
                self.state = .loading
                do {
                    let users: [User] = try await NetworkManager.shared.getUsers(for: Endpoints.user)
                    self.state = .success(users)
                } catch MyError.runtimeError(let error){
                    self.state = .error(error)
                }
            }
        }
        
    }
}
