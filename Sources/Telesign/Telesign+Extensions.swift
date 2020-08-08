//
//  Telesign+Extensions.swift
//  
//
//  Created by Andrew Edwards on 8/7/20.
//

import Vapor
@_exported import TelesignKit

extension Application {
    public var telesign: TelesignClient {
        guard let apiKey = Environment.get("TELESIGN_API_KEY") else {
            fatalError("TELESIGN_API_KEY env var required")
        }
        guard let customerId = Environment.get("TELESIGN_CUSTOMER_ID") else {
            fatalError("TELESIGN_CUSTOMER_ID env var required")
        }
        return .init(httpClient: self.http.client.shared,
                     eventLoop: self.eventLoopGroup.next(),
                     apiKey: apiKey,
                     customerId: customerId)
    }
}

extension Request {
    private struct TelesignKey: StorageKey {
        typealias Value = TelesignClient
    }
    public var telesign: TelesignClient {
        if let existing = application.storage[TelesignKey.self] {
            return existing.hopped(to: self.eventLoop)
        } else {
            guard let apiKey = Environment.get("TELESIGN_API_KEY") else {
                fatalError("TELESIGN_API_KEY env var required")
            }
            guard let customerId = Environment.get("TELESIGN_CUSTOMER_ID") else {
                fatalError("TELESIGN_CUSTOMER_ID env var required")
            }
            
            let new = TelesignClient(httpClient: self.application.http.client.shared,
                                     eventLoop: self.eventLoop,
                                     apiKey: apiKey,
                                     customerId: customerId)
            self.application.storage[TelesignKey.self] = new
            return new
        }
    }
}
