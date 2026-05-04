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
        
        var state: States = .loading
        
        
        init(users: [User]? = nil) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                NetworkManager.shared.getUsers(for: Endpoints.user) { users, error in
                    if let us: [User] = users {
                        self.state = .success(us)
                    }
                    
                    if let error = error {
                        self.state = .error(error)
                    }
                }
            }
        }
        
        func reload() {
            NetworkManager.shared.getUsers(for: Endpoints.user) { users, error in
                if let us: [User] = users {
                    self.state = .success(us)
                }
                
                if let error = error {
                    self.state = .error(error)
                }
            }
        }
        
        enum States {
            case loading
            case success([User])
            case error(String)
        }
           
    }
}
