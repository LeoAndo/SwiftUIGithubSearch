//
//  GithubApiHttpClient.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/08.
//

import Foundation
import Factory

// fetchするHttpClientは各APIごとに用意するのが良さそう
protocol GithubApiHttpClient {
    func fetch<R>(_ request: R) async throws -> R.ResponseEntity where R: GithubServiceRequest
}

final class GithubApiHttpClientImpl: GithubApiHttpClient {
    func fetch<R>(_ request: R) async throws -> R.ResponseEntity where R : GithubServiceRequest {
        var data: Data?
        var response: URLResponse?
        
        do {
            (data, response) =  try await URLSession.shared.data(for: request.asURLRequest())
        } catch {
            // 通信タイムアウトなどのエラーハンドリング - START
            let apiError: APIError
            if let error = error as? NSError, error.domain == NSURLErrorDomain {
                    // NSURLErrorTimedOut: 接続タイムアウト, NSURLErrorCannotFindHost: ホストが見つからなかったため、接続に失敗
                    apiError = .network(error.localizedDescription)
                    throw apiError
            } else {
                apiError = .unexpected("unexpected: \(error.localizedDescription)")
                throw apiError
            }
            // 通信タイムアウトなどのエラーハンドリング - END
        }
        
        // http status code 200以外のエラーハンドリング - START
        if let response = response as? HTTPURLResponse {
            if response.statusCode != HTTPStatusCode.ok.rawValue { // 200以外
                let apiError: APIError
                if let code = response.status {
                    let errorResponse = try JSONDecoder().decode(GithubErrorResponse.self, from: data!)
                    let message = "\(errorResponse.message) : \(errorResponse.documentation_url)"
                    apiError = .http(code, message)
                    throw apiError
                } else {
                    apiError = .unexpected("!!unexpected!!")
                    throw apiError
                }
            }
        }
        // http status code 200以外のエラーハンドリング - END
        
        return try JSONDecoder().decode(R.ResponseEntity.self, from: data!)
    }
}
