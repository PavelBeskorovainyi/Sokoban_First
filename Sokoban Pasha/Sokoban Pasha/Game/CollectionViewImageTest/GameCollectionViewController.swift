//
//  GameCollectionViewController.swift
//  Sokoban Pasha
//
//  Created by Павел Бескоровайный on 22.01.2021.
//

import UIKit
import PKHUD


class GameCollectionViewController: UIViewController{
    
    var collectionData: [String] {
            var array = Array(repeating: "empty", count: (room.width * room.height))
            array.insert("player", at: playerIndex)
            array.insert("box", at: boxIndex)
            array.insert("finish", at: startingDropIndex)
            array.removeLast()
            array.removeLast()
            array.removeLast()
            return array
        }

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        super.viewDidLoad()
        
    }
        
    enum Errors: Error {
        case Left, Down, Up, Right
    }
    
    func wrongStep (index: Int) throws {
        guard index % room.width != 0 else {
            throw Errors.Left
        }
        guard index % room.width != (room.width - 1) else {
            throw Errors.Right
        }
        guard index >= room.width else {
            throw Errors.Up
        }
        guard index < room.width * (room.height - 1) else {
            throw Errors.Down
        }
    }
    
    
    private func move(from: Int, to: Int) {
        collectionView.moveItem(at: IndexPath(item: from, section: 0), to: IndexPath(item: to, section: 0))
    }
    
    private func itemIndex (_ item: Int) -> IndexPath {
        return IndexPath(item: item, section: 0)
    }
    
    
    @IBAction func steps(_ sender: UIButton) {
        
       var player = getIndex(position: game.player)
       var box = getIndex(position: game.box)
        
        
        switch sender.tag {
        
        case 1:
            game.moveOnCollection(go: .left)
            if player % room.width == 0 ||
                box % room.width == 0 && player == box + 1 { break }

            else if player == box + 1 {
                move(from: box, to: box - 1)
                move(from: player, to: player - 1)
            }
            else { move(from: player, to: player - 1) }
            
        case 2:
            game.moveOnCollection(go: .down)
            if player >= room.width * (room.height - 1) ||
                box >= room.width * (room.height - 1) && player == box - room.width { break }
            else if player == box - room.width {
                move(from: box, to: box + room.width)
                move(from: player, to: player + room.width)
                box += room.width
            } else {
                move(from: player, to: player + room.width)
                collectionView.reloadItems(at: [ itemIndex(startingDropIndex), itemIndex(startingDropIndex - 1), itemIndex(player), itemIndex(box - 1), itemIndex(box)
            ]) }

            
        case 3:
            game.moveOnCollection(go: .up)
            if player < room.width ||
                box < room.width && player == box + room.width { break }
            else if player == box + room.width {
                move(from: box, to: box - room.width)
                move(from: player, to: player - room.width)
                box -= room.width
            } else {
            move(from: player, to: player - room.width)
                collectionView.reloadItems(at: [ itemIndex(startingDropIndex), itemIndex(startingDropIndex + 1), itemIndex(player)
            ])
            }
            
        case 4:
            game.moveOnCollection(go: .right)
            if player % room.width == (room.width - 1) ||
                box % room.width == (room.width - 1) { break }
            else if player == box - 1 {
                move(from: box, to: box + 1)
                move(from: player, to: player + 1)
            }
            else { move(from: player, to: player + 1) }
            
            
        case 5:
            move(from: player, to: startingPlayerIndex)
            game.player.positionX = game.startingPlayer.positionX
            game.player.positionY = game.startingPlayer.positionY
            game.box.positionX = game.startingBox.positionX
            game.box.positionY = game.startingBox.positionY
            
        default:
            player = getIndex(position: game.player)
            box = getIndex(position: game.box)
        }
        
        
        
    }
    
    
}
