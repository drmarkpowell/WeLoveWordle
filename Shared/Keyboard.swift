//
//  Keyboard.swift
//  WeLoveWordle
//
//  Created by Mark Powell on 1/17/22.
//

import SwiftUI

struct Keyboard: View {
    @ObservedObject var game: Game
    static let enter = "ENTER"
    static let delete = "DEL"
    let row1 = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
    let row2 = ["A", "S", "D", "F", "G", "H", "J", "K", "L"]
    let row3 = [enter, "Z", "X", "C", "V", "B", "N", "M", delete]
    
    var body: some View {
        VStack {
            HStack {
                ForEach(row1, id: \.self) { name in
                    KeyButton(game: game, keyName: name)
                }
            }
            HStack {
                ForEach(row2, id: \.self) { name in
                    KeyButton(game: game, keyName: name)
                }
            }
            HStack {
                ForEach(row3, id: \.self) { name in
                    KeyButton(game: game, keyName: name)
                }
            }
        }
    }
}

struct Keyboard_Previews: PreviewProvider {
    static var previews: some View {
        Keyboard(game: Game())
    }
}
