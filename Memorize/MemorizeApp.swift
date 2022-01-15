//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Andrew Folz on 11/9/21.
//

import SwiftUI

@main

struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}

struct MemorizeApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
