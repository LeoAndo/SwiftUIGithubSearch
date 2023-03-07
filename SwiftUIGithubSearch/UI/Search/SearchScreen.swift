//
//  ContentView.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/07.
//

import SwiftUI

struct SearchScreen: View {
    @StateObject var viewModel: SearchViewModel
    var body: some View {
        SearchScreenStateless(uiState: viewModel.uiState)
    }
}

struct SearchScreenStateless: View {
    let uiState: UiState
    var body: some View {
        switch self.uiState {
        case .data(let model):
            VStack(spacing: 20) {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text(model.data)
            }
            .padding()
        case .initial:
            EmptyView()
        case .loading:
            ProgressView("fetching…")
                .progressViewStyle(CircularProgressViewStyle())
        case .error(let message):
            Text(message)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchScreenStateless(uiState: UiState.error("Error!!!!"))
            SearchScreenStateless(uiState: UiState.loading)
            SearchScreenStateless(uiState: UiState.initial)
        }
    }
}
