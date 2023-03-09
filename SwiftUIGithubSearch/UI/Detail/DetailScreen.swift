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
    var body: some View {
        Text("\(name) : \(ownerName)")
    }
}

struct DetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailScreen(name: "repo01", ownerName: "owner01")
    }
}
