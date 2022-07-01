//
//  TableCellChooseLanguage.swift
//  SpanishApp
//
//  Created by Shi Ying Nguyen on 13/01/2021.
//

import UIKit

class TableCellChooseLanguage: UITableViewCell {

    @IBOutlet weak var NameLanguage: UILabel!
    @IBOutlet weak var contenView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 2)//CGSizeMake(0, 2.0);
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.3
        if isdark == true {
            NameLanguage.textColor = .white
            contentView.backgroundColor = #colorLiteral(red: 0.04484110964, green: 0.01266181315, blue: 0.2235666436, alpha: 1)
        }
        else{
            NameLanguage.textColor = .black
            contentView.backgroundColor = .white
        }
        // Configure the view for the selected state
    }
    
}
