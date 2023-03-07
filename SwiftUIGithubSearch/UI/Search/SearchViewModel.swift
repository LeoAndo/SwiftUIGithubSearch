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
    init() {
        Task {
            do {
                uiState = UiState.loading
                let result = try await repository.searchRepositories(query: "flutter", page: 1)
                self.uiState = UiState.data(UiState.Data(repositories:result))
            } catch {
                guard let e =  error as? APIError else { return }
                self.uiState = UiState.error(e.message)
            }
        }
    }
}
