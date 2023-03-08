//
//  GithubRepoRepositoryImpl.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/07.
//

import Foundation

final class GithubRepoRepositoryImpl: GithubRepoRepository {
    
    private var client: GithubApiHttpClient

    init(client: GithubApiHttpClient) {
        self.client = client
    }
    func searchRepositories(query: String, page: Int) async throws -> [RepositorySummary] {
        try await client.fetch(GithubService.SearchRepositories(query: query, page: page)).toModels()
    }
}
