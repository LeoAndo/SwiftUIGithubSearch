//
//  HttpClient.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/11.
//

protocol HttpClient {
    func fetch<R>(_ request: R) async throws -> R.ResponseEntity where R: ApiRequest
}
