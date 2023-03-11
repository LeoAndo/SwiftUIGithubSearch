//
//  GithubService.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/07.
//

import Foundation

protocol GithubServiceRequest {
    associatedtype ResponseEntity: Decodable
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    func asURLRequest() throws -> URLRequest
}

extension GithubServiceRequest {
    var baseURL: String { "https://api.github.com" }
    var apiKey: String  { "" } // TODO INPUT HERE GithubAccessToken
}

enum GithubService {
    struct SearchRepositories: GithubServiceRequest {
        static let PER_PAGE = 20
        let query: String
        let page: String
        let perPage: String = String(PER_PAGE)
        let sort: String = "stars"
        init(_ query: String, _ page: Int) {
            self.query = query
            self.page = String(page)
        }
        typealias ResponseEntity = SearchRepositoriesResponse
        var method: HTTPMethod { .get }
        var path: String { "/search/repositories" }
        func asURLRequest() throws -> URLRequest {
            var urlComponents = URLComponents(string: baseURL + path)!
            urlComponents.queryItems = [
                URLQueryItem(name: "q", value: query),
                URLQueryItem(name: "page", value: page),
                URLQueryItem(name: "per_page", value: perPage),
                URLQueryItem(name: "sort", value: sort)
            ]
            var request = URLRequest(url: urlComponents.url!) // timeoutInterval: 0.0001
            request.setHeaders(apiKey: apiKey)
            return request
        }
    }
    struct FetchRepositoryDetail: GithubServiceRequest {
        typealias ResponseEntity = RepositoryDetailResponse
        let ownerName: String
        let repositoryName: String
        var method: HTTPMethod { .get }
        var path: String { "/repos/\(ownerName)/\(repositoryName)" }
        
        init(_ ownerName: String, _ repositoryName: String) {
            self.ownerName = ownerName
            self.repositoryName = repositoryName
        }
        
        func asURLRequest() throws -> URLRequest {
            let urlComponents = URLComponents(string: baseURL + path)!
            var request = URLRequest(url: urlComponents.url!)
            request.setHeaders(apiKey: apiKey)
            return request
        }
    }
}

extension URLRequest {
    mutating func setHeaders(apiKey: String) {
        self.allHTTPHeaderFields = ["Accept": "application/vnd.github.v3+json"]
        if(!apiKey.isEmpty) {
            self.allHTTPHeaderFields = ["Authorization": "Bearer \(apiKey)"]
        }
        self.allHTTPHeaderFields = ["X-GitHub-Api-Version": "2022-11-28"]
    }
}
