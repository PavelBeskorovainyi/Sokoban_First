//
//  Room & Field.swift
//  Sokoban Pasha
//
//  Created by Павел Бескоровайный on 14.01.2021.
//

import Foundation

class Room {
    var width: Int
    var height: Int
    
    init(width: Int, height: Int){
        self.width = width
        self.height = height
    }
}

var room = Room(width: 10, height: 10)
fileprivate let showEmpty = "💨"
fileprivate let showHero = "🏃‍♂️"
fileprivate let showBox = "📦"
fileprivate let wall = "🧨"
fileprivate let endGameSymb = "🕳"


public var field: String {
    var text = ""
    for h in 0...(room.height + 1) {
        var str = ""
        for w in 0...(room.width + 1) {
            switch(w, h) {
            case (0, _): str.append(wall)
            case(_, 0): str.append(wall)
            case (_, room.height + 1): str.append(wall)
            case(room.width + 1, _ ): str.append(wall)
            case (game.player.positionX, game.player.positionY): str.append(showHero)
            case(game.box.positionX, game.box.positionY): str.append(showBox)
            case (game.endGame.positionX, game.endGame.positionY): str.append(endGameSymb)
            default: str.append(showEmpty)
            }
        }
        text.append(str + "\n")
    }
    return text
}
