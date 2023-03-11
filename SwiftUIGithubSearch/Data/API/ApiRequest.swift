//
//  ApiRequest.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/11.
//
import Foundation

protocol ApiRequest {
    associatedtype ResponseEntity: Decodable
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    func asURLRequest() throws -> URLRequest
}
