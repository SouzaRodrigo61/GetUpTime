//
//  Manager+Network.swift
//  GetUp
//
//  Created by Rodrigo Souza on 05/09/24.
//

import Foundation
import Dependencies

extension Manager {
    
    struct Network: Sendable {
        public var get: @Sendable (String) async throws -> Data
        public var post: @Sendable (String, Data?) async throws -> Data
        public var put: @Sendable (String, Data?) async throws -> Data
        public var delete: @Sendable (String) async throws -> Data
    }
}

extension Manager.Network: DependencyKey {
    public static let liveValue = Self(
        get: { endpoint in
            return try await request(endpoint: endpoint, method: "GET")
        },
        post: { endpoint, body in
            return try await request(endpoint: endpoint, method: "POST", body: body)
        },
        put: { endpoint, body in
            return try await request(endpoint: endpoint, method: "PUT", body: body)
        },
        delete: { endpoint in
            return try await request(endpoint: endpoint, method: "DELETE")
        }
    )
    
    private static func request(endpoint: String, method: String, body: Data? = nil) async throws -> Data {
        let baseURL = URL(string: "http://localhost:3000/")!
        let url = baseURL.appendingPathComponent(endpoint)
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body

        // Aplica interceptores na request
        interceptRequest(&request)

        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        return data
    }
    
    private static func interceptRequest(_ request: inout URLRequest) {
        // Exemplo de interceptor: Adicionar cabeçalhos padrão
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // Adicione outros interceptores conforme necessário
    }
}

extension Manager.Network: TestDependencyKey {
    public static let testValue = Self(
        get: { _ in
            return Data("Test GET data".utf8)
        },
        post: { _, _ in
            return Data("Test POST data".utf8)
        },
        put: { _, _ in
            return Data("Test PUT data".utf8)
        },
        delete: { _ in
            return Data("Test DELETE data".utf8)
        }
    )
}