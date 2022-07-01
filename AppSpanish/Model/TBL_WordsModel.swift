//
//  TBL_WordsModel.swift
//  SpanishApp
//
//  Created by Shi Ying Nguyen on 06/01/2021.
//

import Foundation
import UIKit
class TBL_WordsModel{
    public init(id: Int? = nil, native_content: String? = nil, target_content: String? = nil, id_category: Int? = nil, backgroud_img: String? = nil) {
        self.id = id
        self.native_content = native_content
        self.target_content = target_content
        self.id_category = id_category
        self.backgroud_img = backgroud_img
    }
    
    var id : Int?
    var native_content : String?
    var target_content : String?
    var id_category : Int?
    var backgroud_img : String?
}
