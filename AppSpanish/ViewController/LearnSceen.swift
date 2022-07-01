//
//  LearnSceen.swift
//  SpanishApp
//
//  Created by Shi Ying Nguyen on 13/01/2021.
//

import UIKit
import SQLite
import Localize_Swift
var listLikeWords : [TBL_Favorites_WordsModel] = [TBL_Favorites_WordsModel]()
var listLikePhrases : [TBL_Favorites_PhrasesModel] = [TBL_Favorites_PhrasesModel]()
class LearnSceen: UIViewController {
    @IBOutlet weak public var TableLearn: UITableView!
    @IBOutlet weak var Tabbutton: UIButton!
    @IBOutlet var viewAll: UIView!
    @IBOutlet weak var lable1: UILabel!
    @IBOutlet weak var lable2: UILabel!
    @IBOutlet weak var exitbutton: UIButton!
    public var listLearnWords : [A_WordsModel] = [A_WordsModel]()
    public var listLearnPhrases : [A_PhrasesModel] = [A_PhrasesModel]()
    
    var idTopic : Int!
    var choose : Bool = true

    
    override func viewDidLoad() {
        super.viewDidLoad()
        lable1.text = "Phrases".localized()
        lable2.text = "Words".localized()
        exitbutton.setTitle("Accommodation", for: .normal)
        TableLearn.register(UINib(nibName: "TableViewCellLearn", bundle: nil), forCellReuseIdentifier: "TableViewCellLearn")
        
        self.getDataV_WordsModel(){_,_ in
        }
        self.getDataA_PhrasesModel(){_,_ in
        }
        self.getDataTBL_Favorites_WordsModel(){_,_ in
        }
        self.getDataTBL_Favorites_PhrasesModel(){_,_ in
        }
        isDark(Dark: isdark)
    }
    
    func isDark(Dark : Bool){
        if Dark == true {
            viewAll.backgroundColor = #colorLiteral(red: 0.04484110964, green: 0.01266181315, blue: 0.2235666436, alpha: 1)
            self.lable1.textColor = .black
            self.lable2.textColor = .black
            exitbutton.setTitleColor(.white, for: .normal)
            Tabbutton.setBackgroundImage(#imageLiteral(resourceName: "whiteTab"), for: .normal)
        }
        else{
            viewAll.backgroundColor = .white
            self.lable1.textColor = .white
            self.lable2.textColor = .white
            exitbutton.setTitleColor(.black, for: .normal)
            Tabbutton.setBackgroundImage(#imageLiteral(resourceName: "BlackTab"), for: .normal)
        }
    }
    @IBAction func ChoosePhrase(_ sender: UIButton) {
        choose = false
        TableLearn.reloadData()
    }
    @IBAction func ChooseWords(_ sender: Any) {
        choose = true
        TableLearn.reloadData()
    }
    
    func getDataV_WordsModel(andCompletion completion:@escaping (_ moviesResponse: [A_WordsModel], _ error: Error?) -> ()) {
        Service.shared.getV_WordsModel(A: idTopic) { (response, error) in
            if let listData = response{
                self.listLearnWords.removeAll()
                self.listLearnWords = listData
                DispatchQueue.main.async {}
            }
            completion(self.listLearnWords, error)
        }
    }
    func getDataA_PhrasesModel(andCompletion completion:@escaping (_ moviesResponse: [A_PhrasesModel], _ error: Error?) -> ()) {
        Service.shared.getA_PhrasesModel(A : idTopic) { (response, error) in
            if let listData = response{
                self.listLearnPhrases.removeAll()
                self.listLearnPhrases = listData
                DispatchQueue.main.async {}
            }
            completion(self.listLearnPhrases, error)
        }
    }
    func getDataTBL_Favorites_WordsModel(andCompletion completion:@escaping (_ moviesResponse: [TBL_Favorites_WordsModel], _ error: Error?) -> ()) {
        Service.shared.getTBL_Favorites_WordsModel(A: idTopic) { (response, error) in
            if let listData = response{
                listLikeWords.removeAll()
                listLikeWords = listData
                DispatchQueue.main.async {}
            }
            completion(listLikeWords, error)
        }
    }
    func getDataTBL_Favorites_PhrasesModel(andCompletion completion:@escaping (_ moviesResponse: [TBL_Favorites_PhrasesModel], _ error: Error?) -> ()) {
        Service.shared.getTBL_Favorites_PhrasesModel(A : idTopic) { (response, error) in
            if let listData = response{
                listLikePhrases.removeAll()
                listLikePhrases = listData
                DispatchQueue.main.async {}
            }
            completion(listLikePhrases, error)
        }
    }
    @IBAction func clickExit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

@available(iOS 12.0, *)
extension LearnSceen : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if choose==true { return listLearnWords.count}
        else {return listLearnPhrases.count}
    }
    func checkLikeWords(A : Int)->Bool{
        for item in listLikeWords{
            if item.id == A {return true}
        }
        return false
    }
    func checkLikePhrases(A : Int)->Bool{
        for item in listLikePhrases{
            if item.id == A {return true}
        }
        return false
    }
    func tableView(_ tableView: UITableView,  cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.TableLearn.dequeueReusableCell(withIdentifier: "TableViewCellLearn", for: indexPath) as! TableViewCellLearn
        if choose==true {
            if checkLikeWords(A: listLearnWords[indexPath.row].id!) == true {
                cell.imageStar.setBackgroundImage(UIImage(named : "ic_start_favourite_yellow"), for: .normal)
            }
            else {
                cell.imageStar.setBackgroundImage(UIImage(named : "ic_start_favourite_black"), for: .normal)
            }
            cell.lableLearn.text = listLearnWords[indexPath.row].native_content
            cell.actionBlock = {
                let A : TBL_Favorites_WordsModel = TBL_Favorites_WordsModel(id: self.listLearnWords[indexPath.row].id , native_content: self.listLearnWords[indexPath.row].native_content, target_content: self.listLearnWords[indexPath.row].target_content, id_category: self.listLearnWords[indexPath.row].id_category, backgroud_img: self.listLearnWords[indexPath.row].backgroud_img)
                if cell.imageStar.backgroundImage(for: .normal) == UIImage(named : "ic_start_favourite_black") {
                    cell.imageStar.setBackgroundImage(UIImage(named : "ic_start_favourite_yellow"), for: .normal)
                    listLikeWords.append(A)
                    Service.shared.insert_TBL_Favorites_WordsModel(dataInsert: A)
                }
                else{
                    cell.imageStar.setBackgroundImage(UIImage(named : "ic_start_favourite_black"), for: .normal)
                    Service.shared.delete_TBL_Favorites_WordsModel(dataInsert: A)
                }
            }
        }
        else{
            cell.lableLearn.text = listLearnPhrases[indexPath.row].native_content
            if checkLikePhrases(A: listLearnPhrases[indexPath.row].id!) == true {
                cell.imageStar.setBackgroundImage(UIImage(named : "ic_start_favourite_yellow"), for: .normal)
            }
            else {
                cell.imageStar.setBackgroundImage(UIImage(named : "ic_start_favourite_black"), for: .normal)
            }
            cell.actionBlock = {
                let A : TBL_Favorites_PhrasesModel = TBL_Favorites_PhrasesModel(id: self.listLearnPhrases[indexPath.row].id , native_content: self.listLearnPhrases[indexPath.row].native_content, target_content: self.listLearnPhrases[indexPath.row].target_content, id_category: self.listLearnPhrases[indexPath.row].id_category, backgroud_img: self.listLearnPhrases[indexPath.row].backgroud_img)
                if cell.imageStar.backgroundImage(for: .normal) == UIImage(named : "ic_start_favourite_black") {
                    cell.imageStar.setBackgroundImage(UIImage(named : "ic_start_favourite_yellow"), for: .normal)
                    listLikePhrases.append(A)
                    Service.shared.insert_TBL_Favorites_PhrasesModel(dataInsert: A)
                }
                else{
                    cell.imageStar.setBackgroundImage(UIImage(named : "ic_start_favourite_black"), for: .normal)
                    Service.shared.delete_TBL_Favorites_PhrasesModel(dataInsert: A)
                }
            }
        }
        return cell
    }
    @available(iOS 12.0, *)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = TableLearn.cellForRow(at: indexPath) as! TableViewCellLearn
        if(choose == true){
            if cell.lableLearn.text == listLearnWords[indexPath.row].native_content{
                cell.view.backgroundColor = .red
                cell.lableLearn.textColor = UIColor.white
                cell.lableLearn.text = listLearnWords[indexPath.row].target_content
            }else {
                if #available(iOS 13.0, *) {
                    cell.view.backgroundColor = UIColor.systemGray5
                } else {
                    cell.view.backgroundColor = .red
                    // Fallback on earlier versions
                }
                cell.lableLearn.text = listLearnWords[indexPath.row].native_content
                cell.lableLearn.textColor = UIColor.black
            }
        }
        else{
            if cell.lableLearn.text == listLearnPhrases[indexPath.row].native_content{
                cell.view.backgroundColor = .red
                cell.lableLearn.textColor = UIColor.white
                cell.lableLearn.text = listLearnPhrases[indexPath.row].target_content
            }else {
                if #available(iOS 13.0, *) {
                    cell.view.backgroundColor = UIColor.systemGray5
                } else {
                    cell.view.backgroundColor = .red
                    // Fallback on earlier versions
                }
                cell.lableLearn.textColor = UIColor.black
                cell.lableLearn.text = listLearnPhrases[indexPath.row].native_content
            }
        }
        reloadInputViews()
    }
    
}
