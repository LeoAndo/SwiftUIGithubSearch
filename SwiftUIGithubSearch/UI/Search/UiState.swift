//
//  UiState.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/07.
//

import Foundation

enum UiState {
    struct Data { let data: String}
    case initial
    case loading
    case data(Data)
    case error(String)
}
