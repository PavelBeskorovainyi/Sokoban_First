//
//  GetIndexOfPositionForCollectionView.swift
//  Sokoban Pasha
//
//  Created by Павел Бескоровайный on 23.01.2021.
//

import Foundation

func getIndex(position: PositionInRoom) -> Int {
    return ((position.positionX + ((position.positionY - 1) * room.width)) - 1)
}

var startingPlayerIndex = getIndex(position: game.startingPlayer)
var startingBoxIndex = getIndex(position: game.startingBox)
var startingDropIndex = getIndex(position: game.endGame)
var playerIndex = getIndex(position: game.player)
var boxIndex = getIndex(position: game.box)

