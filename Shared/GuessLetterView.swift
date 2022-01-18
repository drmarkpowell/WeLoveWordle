//
//  GuessLetterVIew.swift
//  WeLoveWordle
//
//  Created by Mark Powell on 1/17/22.
//

import SwiftUI

struct GuessLetterView: View {
    @Binding var guessLetter: GuessLetter
    
    var body: some View {
        VStack {
            switch guessLetter.correctness {
            case .correct:
                Text(guessLetter.letter)
                    .frame(width: 40)
                    .padding(8)
                    .background(Color.green)
            case .wrongPositionInWord:
                Text(guessLetter.letter)
                    .frame(width: 40)
                    .padding(8)
                    .background(Color.yellow)
            case .notInWord:
                Text(guessLetter.letter)
                    .frame(width: 40)
                    .padding(8)
                    .background(Color.black.opacity(0.6))
            case .waitingToTapEnter:
                Text(guessLetter.letter)
                    .frame(width: 40)
                    .padding(8)
                    .background(Color.gray.opacity(0.5))
            }
        }
        .font(.largeTitle)
        .foregroundColor(.white)
        .border(Color.accentColor)
    }
}

struct GuessLetterView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            GuessLetterView(
                guessLetter: .constant(GuessLetter(
                    letter: "A",
                    correctness: .correct
                ))
            )
            GuessLetterView(
                guessLetter: .constant(GuessLetter(
                    letter: "B",
                    correctness: .wrongPositionInWord
                ))
            )
            GuessLetterView(
                guessLetter: .constant(GuessLetter(
                    letter: "C",
                    correctness: .notInWord
                ))
            )
            GuessLetterView(
                guessLetter: .constant(GuessLetter(
                    letter: " ",
                    correctness: .waitingToTapEnter
                ))
            )
        }
    }
}
