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
    
    func getUsers<T: Codable>(for endpoint: String, completed: @escaping([T]?, String?) -> Void) {
        
        guard let url = URL(string: endpoint) else {
            completed(nil, "This is an unvalid request")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            if let _ = error {
                completed(nil, "Unable to complete the request")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "Invalid response from the server")
                return
            }
            
            guard let data = data else {
                completed(nil, "The data received from the server was invalid")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode([T].self, from: data)
                
                completed(response, nil)
                
            } catch {
                completed(nil, "The data received from the server was invalid")
            }
            
            
        }
        task.resume()
    }
}
