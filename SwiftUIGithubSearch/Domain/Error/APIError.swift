//
//  APIError.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/07.
//
/// API関連
enum APIError: ApplicationError {
    case http(HTTPStatusCode, String)
    case network(String)
    case unexpected(String)
}
