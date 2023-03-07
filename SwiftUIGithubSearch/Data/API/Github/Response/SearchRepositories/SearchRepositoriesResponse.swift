//
//  SearchRepositoriesResponse.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/07.
//
import Foundation

struct SearchRepositoriesResponse : Decodable {
    let total_count: Int
    let incomplete_results: Bool
    let items: [Item]
    struct Item : Decodable, Identifiable {
        let id: Int
        let name: String
        let owner: Owner
    }
    struct Owner : Decodable {
        let login: String
    }
}

extension SearchRepositoriesResponse {
    func toModels() -> [RepositorySummary] {
        items.map {item in RepositorySummary(id: item.id, name: item.name, ownerName: item.owner.login)  }
    }
}
