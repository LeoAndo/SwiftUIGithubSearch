//
//  GithubRepoRepository.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/07.
//

import Foundation

protocol GithubRepoRepository {
    func searchRepositories(query: String, page: Int) async throws -> [RepositorySummary]
    func fetchRepositoryDetail(ownerName: String, repositoryName: String) async throws -> RepositoryDetail
}
