//
//  LanguageSettingTVC.swift
//  AppSpanish
//
//  Created by Shi Ying Nguyen on 24/01/2021.
//

import UIKit

class LanguageSettingTVC: UITableViewCell {

    @IBOutlet weak var ImageCheck: UIImageView!
    @IBOutlet weak var LangText: UILabel!
    @IBOutlet weak var imageLanguage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if isdark == true {
            LangText.textColor = .white
            contentView.backgroundColor = #colorLiteral(red: 0.04484110964, green: 0.01266181315, blue: 0.2235666436, alpha: 1)
           // #colorLiteral()
        }
        else{
            LangText.textColor = .black
            contentView.backgroundColor = .white
        }
        // Configure the view for the selected state
    }
    
}
