//
//  PlanCache.swift
//  Plan
//
//  Created by Fede Garcia on 05/05/2026.
//

import Foundation

class PlanCache {
    private var cache: [String : NSCache<NSString, NSData>] = [:]
    
    init(key: String = Endpoints.key) {
        setUpCache(key: key)
    }
    
    public func cachedResponse(for endpoint: String, url: URL?) -> Data? {
        guard let targetCache = cache[endpoint], let url = url else {
            return nil
        }
        let key = url.absoluteString as NSString
        return targetCache.object(forKey: key) as? Data
    }
    
    public func setCache ( for key: String, url: URL?, data: Data) {
        guard let targetCache = cache[key], let url = url else { return }
        
        let key = url.absoluteString as NSString
        
        targetCache.setObject(data as NSData, forKey: key)
    }
    
    public func clean() {
        print("Clear cache")
        cache.removeAll()
    }
    
    private func setUpCache(key: String) {
        cache[key] = NSCache<NSString, NSData>()
    }
    
    
    
}
