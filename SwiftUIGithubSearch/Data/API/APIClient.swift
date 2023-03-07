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
//extension Factory.Name {
//    static let github = Self("github")
//}

final class APIClientImpl: APIClient {

    init() {
    }
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
        let typeObjects = try JSONDecoder().decode(R.ResponseEntity.self, from: data)
        return typeObjects
    }
}
