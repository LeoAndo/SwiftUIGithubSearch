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
    @Published var uiState: SearchUiState = SearchUiState()
    private let repository = Container.shared.githubRepoRepository()
    
    func searchRepositories(query: String, page: Int = 1, refresh: Bool = false) {
        Task {
            var repositories = uiState.repositories
            if refresh {
                repositories = []
            }
            
            do {
                // if (query.isEmpty) { throw const InputValidationException("please input search word."); }
                stepToLoadingState(repositories)
                let newItems = try await repository.searchRepositories(query: query, page: page)
                let isLastPage = newItems.count < GithubService.SearchRepositories.PER_PAGE
                stepToData(newItems, isLastPage, page)
            } catch {
                guard let e =  error as? APIError else { return }
                stepToError(repositories, e)
            }
        }
    }
    
    private func stepToLoadingState(_ repositories: [RepositorySummary]) {
        uiState = SearchUiState(repositories: repositories, isLoading: true, apiError: nil)
    }
    
    private func stepToData(_ newItems: [RepositorySummary], _ isLastPage: Bool, _ page: Int) {
        if (isLastPage) {
            uiState = SearchUiState(isFirstFetched: true, repositories: uiState.repositories + newItems, nextPageNo: nil, isLoading: false, apiError: nil)
        } else {
            let nextPageNo = page + 1
            uiState = SearchUiState(isFirstFetched: true, repositories: uiState.repositories + newItems, nextPageNo: nextPageNo, isLoading: false, apiError: nil)
        }
    }
    
    private func stepToError(_ repositories: [RepositorySummary], _ e: APIError) {
        uiState = SearchUiState(repositories: repositories, isLoading: false, apiError: e)
    }
}
