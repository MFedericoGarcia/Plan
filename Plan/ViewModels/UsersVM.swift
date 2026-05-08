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
        
        var network: NetworkManagingProtocol
        
        enum States {
            case loading
            case success([User])
            case error(String)
        }
          
        var state: States = .loading
        
        
        init(network: NetworkManagingProtocol = NetworkManager.shared, users: [User]? = nil) {
            self.network = network
            self.load()
        }
        
        func load() {
            Task { @MainActor in
                self.state = .loading
                do {
                    let users: [User] = try await self.network.getUsers(for: Endpoints.user, with: Endpoints.key)
                    self.state = .success(users)
                } catch MyError.runtimeError(let error){
                    self.state = .error(error)
                }
            }
        }
        
    }
}
