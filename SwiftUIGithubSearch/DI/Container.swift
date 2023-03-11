//
//  Container.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/07.
//

import Foundation
import Factory

extension Container {
    var githubHttpClient: Factory<HttpClient> {
        self { GithubApiHttpClientImpl() }
    }
    var githubRepoRepository: Factory<GithubRepoRepository> {
        self { GithubRepoRepositoryImpl(self.githubHttpClient()) }
    }
}
