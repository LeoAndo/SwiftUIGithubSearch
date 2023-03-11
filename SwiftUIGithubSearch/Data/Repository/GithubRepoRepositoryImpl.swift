//
//  GithubRepoRepositoryImpl.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/07.
//

import Foundation

final class GithubRepoRepositoryImpl: GithubRepoRepository {
    private var client: HttpClient
    init(_ client: HttpClient) {
        self.client = client
    }
    func searchRepositories(query: String, page: Int) async throws -> [RepositorySummary] {
        try await client.fetch(GithubService.SearchRepositories(query, page)).toModels()
    }
    func getRepositoryDetail(ownerName: String, repositoryName: String) async throws -> RepositoryDetail {
        try await client.fetch(GithubService.FetchRepositoryDetail(ownerName, repositoryName)).toModel()
    }
}
