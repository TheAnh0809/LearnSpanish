
//
//  ViewControllerSceen1ViewController.swift
//  SpanishApp
//
//  Created by Shi Ying Nguyen on 10/01/2021.
//

import UIKit
var isdark : Bool = UserDefaults.standard.bool(forKey: "name")
var isDB : String = UserDefaults.standard.string(forKey: "db")!
class StartSpanish: UIViewController {
    @IBOutlet weak var GetStart: UIButton!
    @IBOutlet weak var lableHola: UILabel!
    @IBOutlet weak var lableWelcome: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.string(forKey: "db") == nil {
            UserDefaults.standard.set("_", forKey: "db")
        }
        lableHola.text = "Hola!".localized()
        lableWelcome.text = "Welcome to Learn Spanish".localized()
        GetStart.setTitle("Let get started".localized(), for : .normal)
        GetStart.layer.cornerRadius = 10.0
        GetStart.layer.borderWidth = 1.0
        GetStart.layer.borderColor = UIColor.white.cgColor
        isDark(Dark: isdark)
        // Do any additional setup after loading the view.
    }
    
    func isDark(Dark : Bool){
        if Dark == true {
            GetStart.layer.borderColor = UIColor.black.cgColor
            self.lableHola.textColor = .black
            self.lableWelcome.textColor = .black
            self.GetStart.setTitleColor(.black, for: .normal)
        }
        else{
            GetStart.layer.borderColor = UIColor.white.cgColor
            lableHola.textColor = UIColor.white
            lableHola.textColor = UIColor.white
            GetStart.setTitleColor(.white, for: .normal)
        }
    }
    @IBAction func Click(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if UserDefaults.standard.string(forKey: "db") == "_"{
            let vc:ChooseLanguageSceen = storyboard.instantiateViewController(withIdentifier: "ChooseLanguageSceen") as! ChooseLanguageSceen
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true,completion: nil)
        }
        else{
            let vc:ChooseTopic = storyboard.instantiateViewController(withIdentifier: "ChooseTopic") as! ChooseTopic
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true,completion: nil)
            
        }
    }
}
