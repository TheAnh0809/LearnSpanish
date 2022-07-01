//
//  TabSettingVC.swift
//  AppSpanish
//
//  Created by Shi Ying Nguyen on 20/01/2021.
//

import UIKit
import SideMenu
import FluentDarkModeKit
import Localize_Swift


struct language {
    var language : String
    var image : String
    var check : Bool
}
class TabSettingVC: UIViewController {
    let availableLanguages = Localize.availableLanguages()
    @IBOutlet weak var Setting: UILabel!
    @IBOutlet weak var languaTitle: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var lable3: UILabel!
    @IBOutlet weak var darkmode: UIButton!
    @IBOutlet weak var languagechos: UIButton!
    @IBOutlet weak var LanguageTable: UITableView!
    @IBOutlet weak var aboutApp: UIButton!
    @IBOutlet weak var bookmark: UIButton!
    @IBOutlet weak var ViewSetting: UIView!
    @IBOutlet weak var ViewLanguage: UIView!
    var listLanguage : [String] = ["Chinese",  "English", "French", "German", "Itaian" , "Japanise", "Korean", "Portuguese", "Russian", "Turkish"]
    var list :[language] = [language(language: "Chinese", image: "Chinese", check: false),
                            language(language: "English", image: "English", check: false),
                            language(language: "German", image: "German", check: false),
                            language(language: "French", image: "French", check: false),
                            language(language: "Itaian", image: "Itaian", check: false),
                            language(language: "Japanise", image: "Japanise", check: false),
                            language(language: "Korean", image: "Korean", check: false),
                            language(language: "Portuguese", image: "Portuguese", check: false),
                            language(language: "Russian", image: "Russian", check: false),
                            language(language: "Turkish", image: "Turkish", check: false)]
    var menu : SideMenuNavigationController?
    override func viewDidLoad() {
        LanguageTable.register(UINib(nibName: LanguageSettingTVC.className, bundle: nil), forCellReuseIdentifier: "LanguageSettingTVC")
        menu = SideMenuNavigationController(rootViewController: UIViewController())
        UserDefaults.standard.set(false, forKey: "isdark")
        ViewLanguage.isHidden = true
        SwitchButton.isOn = UserDefaults.standard.bool(forKey: "name")
        Setting.text = "Settings".localized()
        label2.text = "General".localized()
        lable3.text = "Other Settings".localized()
        languaTitle.text = "Language".localized()
        darkmode.setTitle("   Dark mode".localized(), for: .normal)
        bookmark.setTitle("   Bookmark words".localized(), for: .normal)
        aboutApp.setTitle("   About App".localized(), for: .normal)
        languagechos.setTitle("   Language".localized(), for: .normal)
        super.viewDidLoad()
        isDark(Dark: isdark)
        // Do any additional setup after loading the view.
    }
    func isDark(Dark : Bool){
        if Dark == true {
            ViewSetting.backgroundColor = #colorLiteral(red: 0.04484110964, green: 0.01266181315, blue: 0.2235666436, alpha: 1)
            ViewLanguage.backgroundColor = #colorLiteral(red: 0.04484110964, green: 0.01266181315, blue: 0.2235666436, alpha: 1)
            LanguageTable.backgroundColor = #colorLiteral(red: 0.04484110964, green: 0.01266181315, blue: 0.2235666436, alpha: 1)
            languaTitle.textColor = .white
            Setting.textColor = .white
            darkmode.setTitleColor(.white, for: .normal)
            bookmark.setTitleColor(.white, for:.normal)
            label2.textColor = .white
            lable3.textColor = .white
            aboutApp.setTitleColor(.white, for: .normal)
            languagechos.setTitleColor(.white, for: .normal)
            SwitchButton.tintColor = .white
        }
        else{
            ViewSetting.backgroundColor = .white
            ViewLanguage.backgroundColor = .white
            LanguageTable.backgroundColor = .white
            languaTitle.textColor = .black
            Setting.textColor = .black
            darkmode.setTitleColor(.black, for: .normal)
            bookmark.setTitleColor(.black, for:.normal)
            label2.textColor = .black
            lable3.textColor = .black
            aboutApp.setTitleColor(.black, for: .normal)
            languagechos.setTitleColor(.black, for: .normal)
            SwitchButton.tintColor = .black
        }
    }
    @IBAction func DarkMoreClick(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc1:StartSpanish = storyboard.instantiateViewController(withIdentifier: "StartSpanish") as! StartSpanish
        isdark = SwitchButton.isOn
        UserDefaults.standard.set(SwitchButton.isOn, forKey: "name")
        vc1.modalPresentationStyle = .fullScreen
        self.present(vc1, animated: true, completion: nil)
    }
    @IBOutlet weak var SwitchButton: UISwitch!
    @IBAction func languageClick(_ sender: Any) {
        ViewSetting.isHidden = true
        ViewLanguage.isHidden = false
    }
    @IBAction func exitSetting(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func exitLanguage(_ sender: Any) {
        ViewLanguage.isHidden = true
        ViewSetting.isHidden = false
    }
    @IBAction func AboutApp(_ sender: UIButton) {
        let alertController = UIAlertController(title: "<3", message: "_____________".localized(), preferredStyle: UIAlertController.Style.alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            
        })
        
        alertController.addAction(ok)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
}
extension TabSettingVC: UITableViewDelegate, UITableViewDataSource {
    func choose1(A : String?) -> String {
        var B : String = ""
        if A == "Chinese" { B = "db_ChineseToSpanish"}
        if A == "English" { B = "db_EnglishToSpanish"}
        if A == "French" { B = "db_FrenchToSpanish"}
        if A == "German" { B = "db_GermanToSpanish"}
        if A == "Itaian" { B = "db_ItalianToSpanish"}
        if A == "Japanise" { B = "db_JapaniseToSpanish"}
        if A == "Korean" { B = "db_KoreanToSpanish"}
        if A == "Portuguese" { B = "db_PortugueseToSpanish"}
        if A == "Russian" { B = "db_RussianToSpanish"}
        if A == "Turkish" { B = "db_TurkishToSpanish"}
        return B
    }
    func choose2(A : String?) -> String {
        var B : String = ""
        if A == "Chinese" { B = "zh-HK"}
        if A == "English" { B = "Base"}
        if A == "French" { B = "fr"}
        if A == "German" { B = "de"}
        if A == "Itaian" { B = "it"}
        if A == "Japanise" { B = "ja"}
        if A == "Korean" { B = "ko"}
        if A == "Portuguese" { B = "pt-BR"}
        if A == "Russian" { B = "ru"}
        if A == "Turkish" { B = "tr"}
        return B
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listLanguage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.LanguageTable.dequeueReusableCell(withIdentifier: "LanguageSettingTVC", for: indexPath) as! LanguageSettingTVC
        cell.LangText.text = list[indexPath.row].language.localized()
        cell.imageLanguage.image = UIImage(named: list[indexPath.row].image)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //change language
        UserDefaults.standard.set(choose1(A: listLanguage[indexPath.row]), forKey: "db")
        for language in availableLanguages {
            UserDefaults.standard.setValue("English", forKey: "languageKey")
            if language.contains(choose2(A: list[indexPath.row].language)){
                Localize.setCurrentLanguage(language)
                let src = self.storyboard?.instantiateViewController(withIdentifier: "StartSpanish") as! StartSpanish
                UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController = src                                //self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}

