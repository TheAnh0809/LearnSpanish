//
//  TableViewCellLearn.swift
//  SpanishApp
//
//  Created by Shi Ying Nguyen on 11/01/2021.
//

import UIKit

class TableViewCellLearn: UITableViewCell {

    @IBOutlet weak var imageStar: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    var actionBlock: (() -> Void)? = nil
    @IBOutlet weak var lableLearn: UILabel!
    @IBAction func imageStar(_ sender: UIButton) {
        actionBlock?()
    }
    @IBOutlet weak var viewAll: UIView!
    @IBOutlet weak var view: UIView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        view.layer.cornerRadius = 20.0
        self.layer.shadowColor = UIColor.red.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 2)//CGSizeMake(0, 2.0);
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.3
        if isdark == true{
            viewAll.backgroundColor = #colorLiteral(red: 0.04484110964, green: 0.01266181315, blue: 0.2235666436, alpha: 1)
            view.backgroundColor = .lightGray
            lableLearn.textColor = .white
        }
        else {
            viewAll.backgroundColor = .white
            // MARK:
            if #available(iOS 13.0, *) {
                view.backgroundColor = .systemGray6
            } else {
                // Fallback on earlier versions
            }
            lableLearn.textColor = .black
        }
        // Configure the view for the selected state
    }
    
}
