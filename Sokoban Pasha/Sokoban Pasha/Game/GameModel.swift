//
//  GameModel.swift
//  Sokoban Pasha
//
//  Created by Павел Бескоровайный on 09.01.2021.
//

import Foundation

class Game {
    
    public var box = PositionInRoom(positionX: 2, positionY: 2)
    public var startingBox = PositionInRoom(positionX: 2, positionY: 2)
    
    public var player = PositionInRoom(positionX: 1, positionY: 1)
    public var startingPlayer = PositionInRoom(positionX: 1, positionY: 1)
    
    public var endGame = PositionInRoom(positionX: 8, positionY: 8)
    
    enum Steps {
        case left, right, down, up
        
        var stepPosition: (x: Int, y: Int) {
            switch self {
            case .left: return (-1, 0)
            case .right: return (1, 0)
            case .down: return (0, 1)
            case .up: return (0, -1)
            }
        }
    }
    
    func moveOn(go: Steps) -> String {
        
        switch (player.positionX, player.positionY, go) {
        
        case(1, _, .left): break
        case(_, 1, .up): break
        case(room.width, _, .right): break
        case(_, room.height, .down): break
            
        case (box.positionX, (box.positionY + 1), .up), ((box.positionX - 1), box.positionY, .right), ((box.positionX + 1), box.positionY, .left), (box.positionX, (box.positionY - 1), .down):
            
            switch go {
            
            case .up : if box.positionY == 1 {  break }
            else { fallthrough }
            case .right: if box.positionX == room.width && box.positionY == player.positionY { break } else { fallthrough }
            case .left: if box.positionX == 1 && box.positionY == player.positionY { break }
            else { fallthrough }
            case .down: if box.positionY == room.height && box.positionX == player.positionX{ break } else { fallthrough }
                
            default :
                box.positionX += go.stepPosition.x
                box.positionY += go.stepPosition.y
                player.positionX += go.stepPosition.x
                player.positionY += go.stepPosition.y
            }
            
            
        default : player.positionX += go.stepPosition.x
            player.positionY += go.stepPosition.y
        }
        
        if player.positionX == endGame.positionX && player.positionY == endGame.positionY {
            player.positionX = startingPlayer.positionX
            player.positionY = startingPlayer.positionY
        }
        
        return field
    }
    
    func moveOnCollection(go: Steps) {
        
        switch (player.positionX, player.positionY, go) {
        
        case(1, _, .left): break
        case(_, 1, .up): break
        case(room.width, _, .right): break
        case(_, room.height, .down): break
            
        case (box.positionX, (box.positionY + 1), .up), ((box.positionX - 1), box.positionY, .right), ((box.positionX + 1), box.positionY, .left), (box.positionX, (box.positionY - 1), .down):
            
            switch go {
            
            case .up : if box.positionY == 1 {  break }
            else { fallthrough }
            case .right: if box.positionX == room.width && box.positionY == player.positionY { break } else { fallthrough }
            case .left: if box.positionX == 1 && box.positionY == player.positionY { break }
            else { fallthrough }
            case .down: if box.positionY == room.height && box.positionX == player.positionX{ break } else { fallthrough }
                
            default :
                box.positionX += go.stepPosition.x
                box.positionY += go.stepPosition.y
                player.positionX += go.stepPosition.x
                player.positionY += go.stepPosition.y
            }
            
            
        default : player.positionX += go.stepPosition.x
            player.positionY += go.stepPosition.y
        }
        
        if player.positionX == endGame.positionX && player.positionY == endGame.positionY {
            player.positionX = startingPlayer.positionX
            player.positionY = startingPlayer.positionY
        }
    }
    
}

var game = Game()
