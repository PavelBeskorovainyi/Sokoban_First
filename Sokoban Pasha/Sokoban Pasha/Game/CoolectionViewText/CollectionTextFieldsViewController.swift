//
//  CollectionTextFieldsViewController.swift
//  Sokoban Pasha
//
//  Created by Павел Бескоровайный on 24.01.2021.
//

import UIKit
import PKHUD

class CollectionTextFieldsViewController: UIViewController, StoryboardInitializable {
    
    var fieldChars: [String] {
            var array = [String]()
            for ch in fieldWithoutWalls {
                array.append(String(ch))
            }
            return array
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
        super.viewDidLoad()
        
    }
    
    enum Errors: Error {
        case Left, Down, Up, Right
    }
    
    func wrongStep (tag: Int) throws {
        guard tag != 1 else {
            throw Errors.Left
        }
        guard tag != 4 else {
            throw Errors.Right
        }
        guard tag != 2 else {
            throw Errors.Down
        }
        guard tag != 3 else  {
            throw Errors.Up
        }
    }
    
    
    
    
    @IBAction func moveButtons(_ sender: UIButton) {
        
        collectionView.reloadData()
        
        switch sender.tag {
        
        case 1: game.moveOnCollection(go: .left)
            
        case 2: game.moveOnCollection(go: .down)
            
        case 3: game.moveOnCollection(go: .up)
            
        case 4: game.moveOnCollection(go: .right)
            
        case 5:
            game.player.positionX = game.startingPlayer.positionX
            game.box.positionX = game.startingBox.positionX
            game.player.positionY = game.startingPlayer.positionY
            game.box.positionY = game.startingBox.positionY
            
        default: break
            
        }
        do {
            try wrongStep(tag: sender.tag)
        } catch Errors.Left {
            if game.player.positionX == 1 {
                HUD.flash(.labeledError(title: "CANT MOVE LEFT", subtitle: ""), onView: self.view, delay: 0.7)
            }
        } catch Errors.Right {
            if game.player.positionX == room.width {
                HUD.flash(.labeledError(title: "CANT MOVE RIGHT", subtitle: ""), onView: self.view, delay: 0.7)
            }
        } catch Errors.Down {
            if game.player.positionY == room.height {
                HUD.flash(.labeledError(title: "CANT MOVE DOWN", subtitle: ""), onView: self.view, delay: 0.7)
            }
        } catch Errors.Up {
            if game.player.positionY == 1 {
                HUD.flash(.labeledError(title: "CANT MOVE UP", subtitle: ""), onView: self.view, delay: 0.7)
            }
        } catch {
            
        }
        
        if game.box.positionX == game.endGame.positionX && game.box.positionY == game.endGame.positionY {
            
            HUD.flash(.labeledSuccess(title: "YOU WIN", subtitle: "new game started"), onView: self.view, delay: 1.4)
            {
                [weak self, weak game] (_) in
                guard let self = self, let game = game else {return}
                
                game.box.positionX = game.startingBox.positionX
                game.box.positionY = game.startingBox.positionY
                game.player.positionY = game.startingPlayer.positionY
                game.player.positionX = game.startingPlayer.positionX
                self.collectionView.reloadData()
                
            }
        }
    }
}
