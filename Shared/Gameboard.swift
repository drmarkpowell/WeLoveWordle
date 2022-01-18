//
//  Gameboard.swift
//  WeLoveWordle
//
//  Created by Mark Powell on 1/17/22.
//

import SwiftUI

struct Gameboard: View {
    @ObservedObject var game: Game
    
    var body: some View {
        VStack {
            ForEach($game.guesses.guesses, id: \.self) { $guess in
                HStack {
                    ForEach($guess.word, id: \.self) { $letter in
                        GuessLetterView(guessLetter: $letter)
                    }
                }
            }
        }
    }
}

struct Gameboard_Previews: PreviewProvider {
    static var previews: some View {
        Gameboard(game: Game())
    }
}
