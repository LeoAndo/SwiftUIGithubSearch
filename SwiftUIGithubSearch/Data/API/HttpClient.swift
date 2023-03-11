//
//  HttpClient.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/11.
//

/// 実装は各APIごとに用意する
protocol HttpClient {
    func fetch<R>(_ request: R) async throws -> R.ResponseEntity where R: ApiRequest
}
