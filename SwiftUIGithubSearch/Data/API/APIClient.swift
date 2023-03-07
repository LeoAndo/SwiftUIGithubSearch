//
//  APIClient.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/07.
//

import Foundation
import Factory

protocol APIClient {
    func fetch<R>(_ request: R) async throws -> R.ResponseEntity where R: APIRequest
}

final class APIClientImpl: APIClient {
    func fetch<R>(_ request: R) async throws -> R.ResponseEntity where R : APIRequest {
        let (data, response) = try await URLSession.shared.data(for: request.asURLRequest())
        if let response = response as? HTTPURLResponse {
            if response.statusCode != HTTPStatusCode.ok.rawValue {
                let error: APIError
                if let code = response.status {
                    error = .http(code)
                    throw error
                } else {
                    error = .unexpected
                }
            }
        }
        return try JSONDecoder().decode(R.ResponseEntity.self, from: data)
    }
}
