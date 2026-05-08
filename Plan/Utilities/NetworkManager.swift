//
//  NetworkManager.swift
//  Plan
//
//  Created by Fede Garcia on 04/05/2026.
//

import Foundation


protocol NetworkManagingProtocol {
    func getUsers(for endpoint: String, with key: String) async throws -> [User]
}

struct NetworkManager: NetworkManagingProtocol {
    
    static let shared = NetworkManager()
    
    private let cacheManager = PlanCache()
    
    let decoder = JSONDecoder()
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func getUsers<T: Codable>(for endpoint: String, with key: String) async throws -> [T] {
        
        if let cacheData = cacheManager.cachedResponse(for: key , url: URL(string: endpoint)){
            do{
                print("From CACHE")
                return try decoder.decode( [T].self, from: cacheData)
            } catch {
                throw MyError.runtimeError("Unable to load from cache")
            }
        }
        
        guard let url = URL(string: endpoint) else {
            throw MyError.runtimeError("This is an unvalid request")
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
            
        guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
                throw MyError.runtimeError("Invalid response from the server")
            }

            do {
                let result = try decoder.decode([T].self, from: data)
                self.cacheManager.setCache(for: key, url: URL(string: endpoint), data: data)
                print("FROM URLSESSION")
                return result
            } catch {
                throw MyError.runtimeError("The data received from the server was invalid")
            }
            
    }
    
    // MARK: - Cache control
    func clearCache() {
        // Clear all cached responses when app moves to background/termination
        print("Clear cache Manager")

        cacheManager.clean()
    }
}
