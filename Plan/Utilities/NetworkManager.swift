//
//  NetworkManager.swift
//  Plan
//
//  Created by Fede Garcia on 04/05/2026.
//

import Foundation

struct NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {
        
    }
    
    func getUsers<T: Codable>(for endpoint: String) async throws -> [T] {
        
        guard let url = URL(string: endpoint) else {
            throw MyError.runtimeError("This is an unvalid request")
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw MyError.runtimeError("Invalid response from the server")
            }

            do {
                let decoder = JSONDecoder()
                 
            
                return try decoder.decode([T].self, from: data)
                
            } catch {
                throw MyError.runtimeError("The data received from the server was invalid")
            }
            
    }
}
