//
//  UiState.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/07.
//

import Foundation


struct SearchUiState {
    var isFirstFetched: Bool
    var repositories: [RepositorySummary]
    var nextPageNo: Int?
    var isLoading: Bool
    var apiError: APIError?
    
    init(isFirstFetched: Bool = false, repositories: [RepositorySummary] = [], nextPageNo: Int? = 1, isLoading: Bool = false, apiError: APIError? = nil) {
        self.isFirstFetched = isFirstFetched
        self.repositories = repositories
        self.nextPageNo = nextPageNo
        self.isLoading = isLoading
        self.apiError = apiError
    }
}
