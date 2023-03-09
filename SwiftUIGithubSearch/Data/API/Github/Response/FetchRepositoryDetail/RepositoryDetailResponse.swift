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
        let node_id: Int
    }
}

extension RepositoryDetailResponse {
    func toModel() -> RepositoryDetail {
        RepositoryDetail(
            name: self.name,
            owner_avatar_url: self.owner.avatar_url,
            stargazers_count: self.stargazers_count,
            forks_count: self.forks_count,
            open_issues_count: self.open_issues_count,
            watchers_count: self.watchers_count,
            language: self.language,
            description: self.description
        )
    }
}
