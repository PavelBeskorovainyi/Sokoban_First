//
//  CollectionCell.swift
//  Sokoban Pasha
//
//  Created by Павел Бескоровайный on 23.01.2021.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageForCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setModelToUI (name: String) {
        imageForCell.image = UIImage(named: name)
    }

}
