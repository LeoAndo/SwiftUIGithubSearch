//
//  UiState.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/09.
//
enum DetailUiState {
    struct Data { let detail: RepositoryDetail}
    case initial
    case loading
    case data(Data)
    case error(String)
}
