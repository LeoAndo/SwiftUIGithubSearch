//
//  Container.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/07.
//

import Foundation
import Factory

extension Container {
    var apiClient: Factory<APIClient> {
        self {APIClientImpl() }
    }
    var githubRepoRepository: Factory<GithubRepoRepository> {
        self { GithubRepoRepositoryImpl(client: self.apiClient()) }
    }
}
