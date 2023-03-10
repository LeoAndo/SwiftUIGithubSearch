//
//  IconWithText.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/09.
//

import SwiftUI

struct IconWithText: View {
    let systemName: String
    let text: String
    var body: some View {
        HStack {
            Image(systemName: systemName)
            Text(text).font(.body).lineLimit(1)
        }
        .frame(maxWidth: .infinity, alignment: .leading )
        // .background(.orange) // debug
        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
    }
}

struct IconWithText_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // 正常系
            IconWithText(systemName: "globe.americas", text: "Dart")
            // 正常系: 長いメッセージ
            IconWithText(systemName: "globe.americas", text: "AAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBB")
            // 異常系: 不正な画像パス
            IconWithText(systemName: "wgverewg", text: "Dart")
        }
    }
}
