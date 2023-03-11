//
//  Container.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/07.
//

import Foundation
import Factory

extension Container {
    var apiClient: Factory<GithubApiHttpClient> {
        self { GithubApiHttpClientImpl() }
    }
    var githubRepoRepository: Factory<GithubRepoRepository> {
        self { GithubRepoRepositoryImpl(client: self.apiClient()) }
    }
}
