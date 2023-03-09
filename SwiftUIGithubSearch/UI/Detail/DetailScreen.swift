//
//  DetailScreen.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/07.
//

import SwiftUI

struct DetailScreen: View {
    let name: String
    let ownerName: String
    @StateObject var viewModel: DetailViewModel
    var body: some View {
        DetailScreenStateless(uiState: viewModel.uiState, ownerName: ownerName, onReload: {
            viewModel.getRepositoryDetail(name: name, ownerName: ownerName)
        })
        .onAppear {
            viewModel.getRepositoryDetail(name: name, ownerName: ownerName)
        }
    }
}

struct DetailScreenStateless: View {
    let uiState: DetailUiState
    let ownerName: String
    let onReload: () -> Void
    var body: some View {
        switch self.uiState {
        case .initial :
            EmptyView()
        case .loading:
            ProgressView()
        case .error(let message):
            AppError(message: message) { onReload() }
        case .data(let data):
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 20) {
                    AsyncImage(url: URL(string: data.detail.ownerAvatarUrl)) { phase in
                        if let image = phase.image {
                            // Displays the loaded image.
                            image.resizable()
                        } else if phase.error != nil {
                            // Indicates an error.
                            Image(systemName: "person.circle.fill").resizable()
                        } else {
                            // Acts as a placeholder.
                            ProgressView()
                        }
                    }
                    .frame(width: 200, height: 200 )
                    //.background(Color.orange) // debug
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    
                    Text(data.detail.name).font(.largeTitle)
                    Text(ownerName).font(.title)
                    Text(data.detail.description ?? "").font(.body).frame(maxWidth: .infinity, alignment: .leading).padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)).lineLimit(1)
                    Text(data.detail.language ?? "").font(.body)
                    
                    IconWithText(systemName: "globe.americas", text: "\(data.detail.forksCount) forks")
                    IconWithText(systemName: "moon.haze", text: "\(data.detail.stargazersCount) stars")
                    IconWithText(systemName: "atom", text: "\(data.detail.watchersCount) watchers")
                    IconWithText(systemName: "flame.fill", text: "open \(data.detail.openIssuesCount) issues")
                }
            }
        }
    }
}

struct DetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        let detailData: RepositoryDetail = RepositoryDetail(name: "repo01", ownerAvatarUrl: "https://avatars.githubusercontent.com/u/14101776?v=4", stargazersCount: 100, forksCount: 200, openIssuesCount: 300, watchersCount: 400, language: "Dart", description: "description abcdefghijklmnopqrstuvwxyz abcdefghijklmnopqrstuvwxyz")
        let detailErrorData: RepositoryDetail = RepositoryDetail(name: "repo01", ownerAvatarUrl: "errorUrl", stargazersCount: 100, forksCount: 200, openIssuesCount: 300, watchersCount: 400, language: nil, description: nil)
        
        Group {
            DetailScreenStateless(uiState: .initial, ownerName: "owner01") {}
            DetailScreenStateless(uiState: .loading, ownerName: "owner01"){}
            DetailScreenStateless(uiState: .error("!!!!error!!!!"), ownerName: "owner01"){}
            DetailScreenStateless(uiState: .data(DetailUiState.Data(detail: detailData)), ownerName: "owner01"){}
            // Image取得失敗 & language と description nilケース
            DetailScreenStateless(uiState: .data(DetailUiState.Data(detail: detailErrorData)), ownerName: "owner01"){}
        }
    }
}
