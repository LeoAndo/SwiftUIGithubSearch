//
//  ContentView.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/07.
//

import SwiftUI
import Factory

struct SearchScreen: View {
    @StateObject var viewModel: SearchViewModel
    var body: some View {
        MainContent(uiState: viewModel.uiState) { query in
            viewModel.searchRepositories(query: query, page: 1)
        }
    }
}

struct MainContent: View {
    let uiState: UiState
    let onSubmit: ((String) -> Void)
    @State var inputText = "" // TextFieldがBinding<String> に依存するのでStatelessにできない
    var body: some View {
        VStack() {
            TextField("キーワード", text: $inputText, prompt: Text("キーワードを入力してください"))
                .onSubmit { onSubmit(inputText) }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Spacer()
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
            Spacer()
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
                    LazyVStack(spacing: 0) {
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
        Group {
            let successData: [RepositorySummary] = [
                RepositorySummary(id: 1, name: "repo01", ownerName: "owner01"),
                RepositorySummary(id: 2, name: "repo02", ownerName: "owner02"),
                RepositorySummary(id: 3, name: "repo03", ownerName: "owner03"),
                RepositorySummary(id: 4, name: "repo04", ownerName: "owner04"),
                RepositorySummary(id: 5, name: "repo05", ownerName: "owner05"),
                RepositorySummary(id: 6, name: "repo06", ownerName: "owner06"),
            ]
            // repositoryをfakeに差し替える - START
            // let _ = Container.shared.githubRepoRepository.register { FakeGithubRepoRepository() }
            // repositoryをfakeに差し替える - END
            MainContent(uiState: .initial, onSubmit: {_ in }, inputText: "Flutter")
            MainContent(uiState: UiState.loading, onSubmit: {_ in }, inputText: "Flutter")
            MainContent(uiState:UiState.data(UiState.Data(repositories:successData)), onSubmit: {_ in }, inputText: "Flutter")
            MainContent(uiState: UiState.error("Error!!!!"), onSubmit: {_ in }, inputText: "Flutter")
        }
    }
}


