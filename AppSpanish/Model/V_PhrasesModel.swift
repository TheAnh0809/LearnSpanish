//
//  V_PhrasesModel.swift
//  SpanishApp
//
//  Created by Shi Ying Nguyen on 06/01/2021.
//

import Foundation
import UIKit
class A_PhrasesModel {
    var id : Int?
    var native_content : String?
    var target_content : String?
    var id_category : Int?
    var backgroud_img : String?
    var content_type : String?
    var has_favorites : String?
    internal init(id: Int? = nil, native_content: String? = nil, target_content: String? = nil, id_category: Int? = nil, backgroud_img: String? = nil, content_type : String? = nil, has_favorites : String? = nil) {
        self.id = id
        self.native_content = native_content
        self.target_content = target_content
        self.id_category = id_category
        self.backgroud_img = backgroud_img
        self.content_type = content_type
        self.has_favorites = has_favorites
    }
}
