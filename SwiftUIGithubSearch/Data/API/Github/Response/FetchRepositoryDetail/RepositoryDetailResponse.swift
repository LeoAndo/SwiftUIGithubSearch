//
//  RepositoryDetailResponse.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/09.
//

struct RepositoryDetailResponse : Decodable {
    let forks_count: Int
    let id: Int
    let name: String
    let open_issues_count: Int
    let owner: Owner
    let stargazers_count: Int
    let watchers_count: Int
    let language: String?
    let description: String?
    struct Owner : Decodable {
        let avatar_url: String
        let id: Int
    }
}

extension RepositoryDetailResponse {
    func toModel() -> RepositoryDetail {
        RepositoryDetail(
            name: self.name,
            ownerAvatarUrl: self.owner.avatar_url,
            stargazersCount: self.stargazers_count,
            forksCount: self.forks_count,
            openIssuesCount: self.open_issues_count,
            watchersCount: self.watchers_count,
            language: self.language,
            description: self.description
        )
    }
}
