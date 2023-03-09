//
//  RepositoryDetail.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/09.
//
struct RepositoryDetail: Decodable {
    let name: String
    let ownerAvatarUrl: String
    let stargazersCount: Int
    let forksCount: Int
    let openIssuesCount: Int
    let watchersCount: Int
    let language: String?
    let description: String?
}
