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
        case .initial:
            EmptyView()
        case .error(let message):
            Text(message)
        case .loading:
            ProgressView("fetching…")
                .progressViewStyle(CircularProgressViewStyle())
        case .data(let data):
            ScucessView(repositories: data.repositories)
        }
    }
}

/// 正常系で表示するView
struct ScucessView: View {
    let repositories: [RepositorySummary]
    var body: some View {
        VStack(spacing: 0) {
            if !repositories.isEmpty {
                ScrollView(.vertical, showsIndicators: true) {
                    LazyVStack(spacing: 20) {
                        ForEach(repositories) { repository in
                            VStack(alignment: .leading) {
                                Text(repository.name)
                                Text(repository.ownerName)
                                Divider()
                            }
                            .frame(maxWidth: .infinity)
                            .padding([.leading, .trailing], 8)
                        }
                    }
                }
            } else {
                Text("result empty...")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let successData: [RepositorySummary] = [
            RepositorySummary(id: 1, name: "repo01", ownerName: "owner01"),
            RepositorySummary(id: 2, name: "repo02", ownerName: "owner02"),
            RepositorySummary(id: 3, name: "repo03", ownerName: "owner03"),
            RepositorySummary(id: 3, name: "repo04", ownerName: "owner04"),
            RepositorySummary(id: 3, name: "repo05", ownerName: "owner05"),
            RepositorySummary(id: 3, name: "repo06", ownerName: "owner06"),
        ]
        Group {
            SearchScreenStateless(uiState: UiState.initial)
            SearchScreenStateless(uiState: UiState.loading)
            SearchScreenStateless(uiState: UiState.data(UiState.Data(repositories: successData)))
            SearchScreenStateless(uiState: UiState.error("Error!!!!"))
        }
    }
}


