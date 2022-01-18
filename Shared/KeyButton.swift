//
//  KeyButton.swift
//  WeLoveWordle
//
//  Created by Mark Powell on 1/17/22.
//

import SwiftUI

struct KeyButton: View {
    @ObservedObject var game: Game
    var keyName: String
    var body: some View {
        Button {
            switch keyName {
            case Keyboard.enter:
                game.commitGuess()
            case Keyboard.delete:
                game.deleteLetter()
            default:
                game.addLetter(letter: keyName)
            }
        } label: {
            Text(keyName)
        }
        .font(.caption)
        .padding(10)
        .background(color())
        .foregroundColor(.white)
    }
    
    func color() -> Color {
        if let correctness = game.keyStates[keyName] {
            switch correctness {
            case .waitingToTapEnter:
                return Color.gray
            case .notInWord:
                return Color.gray.opacity(0.2)
            case .wrongPositionInWord:
                return Color.yellow
            case .correct:
                return Color.green
            }
        }
        return Color.gray
    }
}

struct KeyButton_Previews: PreviewProvider {
    static var previews: some View {
        KeyButton(game: Game(), keyName: "Q")
    }
}
