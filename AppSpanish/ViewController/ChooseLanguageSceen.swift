//
//  ChooseLanguageSceen.swift
//  SpanishApp
//
//  Created by Shi Ying Nguyen on 11/01/2021.
//

import UIKit
import Localize_Swift
class ChooseLanguageSceen: UIViewController {
    let availableLanguages = Localize.availableLanguages()
    @IBOutlet weak var lable1: UILabel!
    @IBOutlet var viewAll: UIView!
    @IBOutlet weak var lable2: UILabel!
    @IBOutlet weak var lable3: UILabel!
    @IBOutlet weak var TableChooseLanguage: UITableView!
    @IBOutlet weak var Tabbutton: UIButton!
    var listLanguage : [String] = ["Chinese",  "English", "French", "German", "Itaian" , "Japanise", "Korean", "Portuguese", "Russian", "Turkish"]
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set("_", forKey: "db")
        lable1.text = "Learn Spanish".localized()
        lable2.text = "Choose your\nlanguage" .localized()
        lable3.text = "Select the language to get started.".localized()
        TableChooseLanguage.register(UINib(nibName: TableCellChooseLanguage.className, bundle: nil), forCellReuseIdentifier: "TableCellChooseLanguage")
        isDark(Dark: isdark)
    }
    func isDark(Dark : Bool){
        if Dark == true {
            viewAll.backgroundColor = #colorLiteral(red: 0.04484110964, green: 0.01266181315, blue: 0.2235666436, alpha: 1)
            self.lable1.textColor = .white
            self.lable2.textColor = .white
            lable3.textColor = .white
            Tabbutton.setBackgroundImage(#imageLiteral(resourceName: "whiteTab"), for: .normal)
        }
        else{
            viewAll.backgroundColor = .white
            self.lable1.textColor = .black
            self.lable2.textColor = .black
            lable3.textColor = .black
            
        }
    }
    
}
extension ChooseLanguageSceen: UITableViewDelegate, UITableViewDataSource {
    func choose(A : String?) -> String {
        var B : String = ""
        switch A {
        case "Chinese": B = "db_ChineseToSpanish"
        case "English": B = "db_EnglishToSpanish"
        case "French": B = "db_FrenchToSpanish"
        case "German": B = "db_GermanToSpanish"
        case "Itaian": B = "db_ItalianToSpanish"
        case "Japanise": B = "db_JapaniseToSpanish"
        case "Korean": B = "db_KoreanToSpanish"
        case "Portuguese": B = "db_PortugueseToSpanish"
        case "Russian": B = "db_RussianToSpanish"
        case "Turkish": B = "db_TurkishToSpanish"
        default : break
        }
        return B
    }
    func choose2(A : String?) -> String {
        var B : String = ""
        switch A {
        case "Chinese": B = "zh-HK"
        case "English": B = "Base"
        case "French": B = "fr"
        case "German": B = "de"
        case "Itaian": B = "it"
        case "Japanise": B = "ja"
        case "Korean": B = "ko"
        case "Portuguese": B = "pt-BR"
        case "Russian": B = "ru"
        case "Turkish": B = "tr"
        default : break
        }
        return B
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listLanguage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.TableChooseLanguage.dequeueReusableCell(withIdentifier: "TableCellChooseLanguage", for: indexPath) as! TableCellChooseLanguage
        cell.NameLanguage.text = listLanguage[indexPath.row].localized()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc:ChooseTopic = storyboard.instantiateViewController(withIdentifier: "ChooseTopic") as! ChooseTopic
        vc.modalPresentationStyle = .fullScreen
        if isDB == "_"{
            vc.nameSQL = choose(A: listLanguage[indexPath.row])
            UserDefaults.standard.set(choose(A: listLanguage[indexPath.row]), forKey: "db")
        }
        else{
            vc.nameSQL = String(UserDefaults.standard.string(forKey: "db")!)
        }
        UserDefaults.standard.set(listLanguage[indexPath.row] ,forKey: "languageKey")
        for language in availableLanguages {
            UserDefaults.standard.setValue("English", forKey: "languageKey")
            if language.contains(choose2(A: listLanguage[indexPath.row])){
                Localize.setCurrentLanguage(language)
            }
        }
        self.present(vc, animated: true, completion: nil)
    }
}
