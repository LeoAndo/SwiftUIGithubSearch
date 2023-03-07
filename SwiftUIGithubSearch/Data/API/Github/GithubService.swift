//
//  GithubService.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/07.
//

import Foundation

protocol GithubServiceRequest: APIRequest {}

extension GithubServiceRequest {
    var baseURL: String { APIBaseURL.github.value }
    var apiKey: String  { "" } // TODO INPUT HERE GithubAccessToken
}

enum GithubService {
    struct SearchRepositories: GithubServiceRequest {
        let query: String
        let page: String
        let perPage: String = "20"
        let sort: String = "stars"
        init(query: String, page: Int) {
            self.query = query
            self.page = String(page)
        }
        typealias ResponseEntity = SearchRepositoriesResponse
        var method: HTTPMethod { .get }
        var path: String = "/search/repositories"
        func asURLRequest() throws -> URLRequest {
            var urlComponents = URLComponents(string: baseURL + path)!
            urlComponents.queryItems = [
                URLQueryItem(name: "q", value: query),
                URLQueryItem(name: "page", value: page),
                URLQueryItem(name: "per_page", value: perPage),
                URLQueryItem(name: "sort", value: sort)
            ]
            var request = URLRequest(url: urlComponents.url!)
            request.allHTTPHeaderFields = ["Accept": "application/vnd.github.v3+json"]
            if(!apiKey.isEmpty) {
                request.allHTTPHeaderFields = ["Authorization": "Bearer \(apiKey)"]
            }
            request.allHTTPHeaderFields = ["X-GitHub-Api-Version": "2022-11-28"]
            return request
        }
    }
}
