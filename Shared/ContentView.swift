//
//  ContentView.swift
//  Shared
//
//  Created by Mark Powell on 1/17/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var game = Game()
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Gameboard(game: game)
                switch game.gameState {
                case .initializing:
                    ProgressView()
                case .win:
                    Text("You got it!")
                        .font(.title)
                case .lose:
                    Text("No more guesses, the answer is \(game.getAnswer())")
                        .font(.headline)
                case .unrecognizedWord:
                    Text("Unrecognized word, please try again.")
                case .playing:
                    EmptyView()
                }
                Spacer()
                Keyboard(game: game)
            }
            .navigationTitle("Guess My Word")
        }
        .onAppear {
            Task {
                try await game.loadWords()
                game.gameState = .playing
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .clipped()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
