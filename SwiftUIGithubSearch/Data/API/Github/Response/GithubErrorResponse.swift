//
//  GithubErrorResponse.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/08.
//

import Foundation

struct GithubErrorResponse : Decodable {
    let message: String
    let documentation_url: String
}
