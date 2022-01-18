//
//  GuessesViewModel.swift
//  WeLoveWordle
//
//  Created by Mark Powell on 1/17/22.
//

import Foundation

class GuessesViewModel: ObservableObject {
    @Published var guesses = [Guess]()
    
    init() {
        for _ in 1...Game.numGuesses {
            guesses.append(Guess())
        }
    }
}

struct Guess: Identifiable, Hashable {
    var id = UUID().uuidString
    var word = [GuessLetter]()
    var committed = false
    
    init() {
        for _ in 0..<Game.wordLength {
            word.append(GuessLetter())
        }
    }
    
    func getWord() -> String {
        var theWord = ""
        word.forEach { theWord += $0.letter }
        return theWord
    }
    
    mutating func compareLetters(answer: String, game: Game) {
        for (position, letter) in word.enumerated() {
            let letterInAnswer = String(answer[answer.index(answer.startIndex, offsetBy: position)])
            if letter.letter == letterInAnswer {
                word[position].correctness = .correct
                game.keyStates[letter.letter] = .correct
            } else if answer.contains(letter.letter) {
                word[position].correctness = .wrongPositionInWord
                game.keyStates[letter.letter] = .wrongPositionInWord
            } else {
                word[position].correctness = .notInWord
                game.keyStates[letter.letter] = .notInWord
            }
        }
    }
        
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct GuessLetter: Identifiable, Hashable {
    var id = UUID().uuidString
    var letter: String = " "
    var correctness: Correctness = .waitingToTapEnter
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

enum Correctness {
    case waitingToTapEnter
    case notInWord
    case wrongPositionInWord
    case correct
}
