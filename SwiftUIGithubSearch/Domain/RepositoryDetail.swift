//
//  RepositoryDetail.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/09.
//
struct RepositoryDetail: Decodable {
    let name: String
    let owner_avatar_url: String
    let stargazers_count: Int
    let forks_count: Int
    let open_issues_count: Int
    let watchers_count: Int
    let language: String?
    let description: String?
}
