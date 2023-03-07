//
//  SearchViewModel.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/07.
//

import Foundation

@MainActor
final class SearchViewModel : ObservableObject {
    @Published var uiState: UiState = UiState.initial
    
    init() {
        uiState = UiState.loading
        Task {
            do {
                try await Task.sleep(nanoseconds: UInt64(2 * 1_000_000_000)) // 2秒待つ
               //  let photos = try await repository.searchPhotos()
                self.uiState = UiState.data(UiState.Data(data:"Hello, SwiftUI!!!"))
            } catch {
                guard let e =  error as? APIError else { return }
                self.uiState = UiState.error(e.message)
            }
        }
    }
}
