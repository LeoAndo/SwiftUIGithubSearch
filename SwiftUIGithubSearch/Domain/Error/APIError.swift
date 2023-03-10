//
//  APIError.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/07.
//
/// APIErrorを汎用的な名前に変える
enum APIError: ApplicationError {
    // API関連
    case http(HTTPStatusCode, String)
    case network(String)
    case unexpected(String)
    // 入力バリデーション関連
    case input(String)
}
