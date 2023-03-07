//
//  RepositorySummary.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/07.
//

import Foundation

struct RepositorySummary : Decodable, Identifiable {
    let id: Int
    let name: String
    let ownerName: String
}
