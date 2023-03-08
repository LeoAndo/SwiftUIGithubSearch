//
//  SearchViewModel.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/07.
//

import Foundation
import Factory

@MainActor
final class SearchViewModel : ObservableObject {
    @Published var uiState: UiState = UiState.initial
    private let repository = Container.shared.githubRepoRepository()
    func searchRepositories(query: String, page: Int) {
        Task {
            do {
                uiState = UiState.loading
                let result = try await repository.searchRepositories(query: query, page: page)
                self.uiState = UiState.data(UiState.Data(repositories:result))
            } catch {
                guard let e =  error as? APIError else { return }
                switch(e) {
                case .http(let code, let message):
                    self.uiState = UiState.error("\(code) : \(message)")
                case .unexpected(let message):
                    self.uiState = UiState.error("\(message)")
                case .network(let message): // 接続エラー
                    self.uiState = UiState.error("\(message)")
                }
            }
        }
    }
}
