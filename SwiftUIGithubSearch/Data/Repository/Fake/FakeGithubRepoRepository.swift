//
//  FakeGithubRepoRepository.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/07.
//

import Foundation
final class FakeGithubRepoRepository: GithubRepoRepository {
    let successData: [RepositorySummary] = [
        RepositorySummary(id: 1, name: "repo01", ownerName: "owner01"),
        RepositorySummary(id: 2, name: "repo02", ownerName: "owner02"),
        RepositorySummary(id: 3, name: "repo03", ownerName: "owner03"),
        RepositorySummary(id: 4, name: "repo04", ownerName: "owner04"),
        RepositorySummary(id: 5, name: "repo05", ownerName: "owner05"),
        RepositorySummary(id: 6, name: "repo06", ownerName: "owner06"),
    ]
    func searchRepositories(query: String, page: Int) async throws -> [RepositorySummary] {
         successData
    }
    func fetchRepositoryDetail(ownerName: String, repositoryName: String) async throws -> RepositoryDetail {
        RepositoryDetail(name: "repoName01", owner_avatar_url: "https://avatars.githubusercontent.com/u/5429470?v=4", stargazers_count: 100, forks_count: 200, open_issues_count: 300, watchers_count: 400, language: "Dart", description: "flutter description01")
    }
}
