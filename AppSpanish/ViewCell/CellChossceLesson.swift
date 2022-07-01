//
//  CellChossceLesson.swift
//  SpanishApp
//
//  Created by Shi Ying Nguyen on 08/01/2021.
//

import UIKit

class CellChossceLesson: UICollectionViewCell {
    
    @IBOutlet weak var prosetView: UIProgressView!
    @IBOutlet weak var contentV: UIView!
    @IBOutlet weak var lableNameTopic: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var viewAll: UIView!
    @IBOutlet weak var lableTopic: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // MARK:
        if #available(iOS 13.0, *) {
            viewAll.backgroundColor = UIColor.systemGray6
        } else {
            // Fallback on earlier versions
        }
        imageCell.layer.cornerRadius = 10.0
        viewAll.layer.cornerRadius = 15.0
        viewAll.layer.borderWidth = 0.5
        // MARK:
        if #available(iOS 13.0, *) {
            viewAll.layer.borderColor = UIColor.systemGray6.cgColor
        } else {
            viewAll.layer.borderColor = UIColor.clear.cgColor
            // Fallback on earlier versions
        }
        viewAll.layer.shadowColor = UIColor.red.cgColor
        viewAll.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewAll.layer.shadowRadius = 5.0
        viewAll.layer.shadowOpacity = 0.7
        viewAll.layer.masksToBounds = false //<-
        if isdark == true {
            viewAll.backgroundColor = .darkGray
            lableTopic.textColor = .white
            lableNameTopic.textColor = .white
        }
        else {
            viewAll.backgroundColor = #colorLiteral(red: 1, green: 0.9623344575, blue: 0.9714057237, alpha: 1)
            lableTopic.textColor = .black
            lableNameTopic.textColor = .black
        }

        // Initialization code
    }

}
