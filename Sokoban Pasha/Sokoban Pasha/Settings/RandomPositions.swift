//
//  RandomPositions.swift
//  Sokoban Pasha
//
//  Created by Павел Бескоровайный on 28.01.2021.
//

import Foundation

public func setRandomPositions() {
    
   let playerRandom = (x: Int.random(in: 1...room.width), y: Int.random(in: 1...room.height))
   let boxRandom = (x: Int.random(in: 1...room.width), y: Int.random(in: 1...room.height))
   let dropRandom = (x: Int.random(in: 1...room.width), y: Int.random(in: 1...room.height))
    
    if playerRandom == boxRandom || boxRandom == dropRandom || playerRandom == dropRandom {
        return
    } else {
    game.startingPlayer.positionX = playerRandom.x
        game.startingPlayer.positionY = playerRandom.y
        game.startingBox.positionX = boxRandom.x
        game.startingBox.positionY = boxRandom.y
        game.endGame.positionX = dropRandom.x
        game.endGame.positionY = dropRandom.y
    }
}
