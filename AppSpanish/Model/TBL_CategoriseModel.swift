//
//  BTL_CategoriseModel.swift
//  SpanishApp
//
//  Created by Shi Ying Nguyen on 06/01/2021.
//

import Foundation
import UIKit
class TBL_CategoriseModel{
    var id : Int = 0
    var name : String = ""
    var image_name : String = ""
    var image_info : String = ""
    
    init(id: Int = 0, name: String = "", image_name: String = "", image_info: String = "") {
       self.id = id
       self.name = name
       self.image_name = image_name
       self.image_info = image_info
   }
    
}
