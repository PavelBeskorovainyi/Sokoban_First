//
//  ExtensionTextViewCollection.swift
//  Sokoban Pasha
//
//  Created by Павел Бескоровайный on 24.01.2021.
//

import Foundation
import UIKit

extension CollectionTextFieldsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return room.width * room.height
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionID", for: indexPath) as! CollectionViewCell
        cell.setTextToUI(fieldChars[indexPath.item])
        cell.automaticallyUpdatesContentConfiguration = true
        cell.autoresizesSubviews = true
        cell.textView.adjustsFontForContentSizeCategory = true
        
        let width = Int(collectionView.frame.size.width) / room.width
        let height = Int(collectionView.frame.size.height) / room.height
        var fontSize: Int {
            width < height ? width - 5 : height - 5
        }
        let font = UIFont(name: "Helvetica", size: CGFloat(fontSize)) ?? UIFont()
        cell.textView.font = font
        
        return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Int(collectionView.frame.size.width) / room.width
        let height = Int(collectionView.frame.size.height) / room.height
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}
