//
//  APIRequest.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/07.
//

import Foundation

protocol APIRequest {
    associatedtype ResponseEntity: Decodable
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    func asURLRequest() throws -> URLRequest
}

enum APIBaseURL {
    case github
    var value: String {
        switch self {
        case .github:
            return "https://api.github.com"
        }
    }
}
