//
//  AppError.swift
//  SwiftUIGithubSearch
//
//  Created by LeoAndo on 2023/03/09.
//

import SwiftUI

/// エラー表示用共通View
struct AppError: View {
    var message: String = "default message: error"
    var padding: EdgeInsets = EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
    let onReload: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            Text(message)
                .frame(maxWidth: .infinity)
                .foregroundColor(.red)
                .lineLimit(1)
            Button(action:  {
                onReload()
            }, label:  {
                Text("reload")
            })
        }.padding(padding)
    }
}

struct AppError_Previews: PreviewProvider {
    static var previews: some View {
        AppError(message: "error.") {
            
        }
        AppError(message: "long message asadfveagverrbvergbergvergvergvergvergverg") {
            
        }
        AppError() {
            
        }
    }
}
