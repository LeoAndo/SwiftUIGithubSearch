//
//  DetailViewModel.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/09.
//

import Foundation
import Factory

@MainActor
final class DetailViewModel : ObservableObject {
    @Published var uiState: DetailUiState = DetailUiState.initial
    private let repository = Container.shared.githubRepoRepository()
    
    func getRepositoryDetail(name: String, ownerName: String) {
        Task {
            do {
                uiState = DetailUiState.loading
                let result = try await repository.getRepositoryDetail(ownerName: ownerName, repositoryName: name)
                self.uiState = DetailUiState.data(DetailUiState.Data(detail:result))
            } catch {
                if let apiError = error as? APIError {
                    switch(apiError) {
                    case .http(let code, let message):
                        self.uiState = DetailUiState.error("\(code) : \(message)")
                    case .network(let message), .unexpected(let message):
                        self.uiState = DetailUiState.error("\(message)")
                    }
                } else {
                    self.uiState = DetailUiState.error(error.localizedDescription)
                }
            }
        }
    }
}
