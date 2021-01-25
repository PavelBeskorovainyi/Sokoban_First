//
//  CollectionViewCell.swift
//  Sokoban Pasha
//
//  Created by Павел Бескоровайный on 24.01.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var textView: UITextView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.textView.font = UIFont.preferredFont(forTextStyle: .body)
        self.textView.adjustsFontForContentSizeCategory = true
    }
    
    func setTextToUI (_ text: String) {
        textView.text = text
    }

}
