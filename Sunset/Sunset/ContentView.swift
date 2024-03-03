//
//  ContentView.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 2/2/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .sunsetFontPrimary(primaryFont: .primaryBold, primarySize: .displayS)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
