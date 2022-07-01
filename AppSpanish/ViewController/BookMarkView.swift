//
//  BookMarkView.swift
//  AppSpanish
//
//  Created by Shi Ying Nguyen on 02/02/2021.
//

import UIKit

class BookMarkView: UIViewController {
    var choose : Bool = true
    @IBOutlet weak var exit: UIButton!
    @IBOutlet var viewAll: UIView!
    @IBOutlet weak var wordsTable: UITableView!
    @IBOutlet weak var titlelable: UILabel!
    @IBOutlet weak var ChooseTab: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        wordsTable.register(UINib(nibName: "TableViewCellLearn", bundle: nil), forCellReuseIdentifier: "TableViewCellLearn")
        titlelable.text = "Bookmark words/phrases".localized()
        ChooseTab.setTitle("Words".localized(), forSegmentAt: 0)
        ChooseTab.setTitle("Phrases".localized(), forSegmentAt: 1)
        self.getDataTBL_Favorites_WordsModel(){_,_ in
        }
        self.getDataTBL_Favorites_PhrasesModel(){_,_ in
        }
        isDark(Dark: isdark)
        // Do any additional setup after loading the view.
    }
    @IBAction func exitClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func getDataTBL_Favorites_WordsModel(andCompletion completion:@escaping (_ moviesResponse: [TBL_Favorites_WordsModel], _ error: Error?) -> ()) {
        Service.shared.getAllTBL_Favorites_WordsModel() { (response, error) in
            if let listData = response{
                listLikeWords.removeAll()
                listLikeWords = listData
                DispatchQueue.main.async {}
            }
            completion(listLikeWords, error)
        }
    }
    func getDataTBL_Favorites_PhrasesModel(andCompletion completion:@escaping (_ moviesResponse: [TBL_Favorites_PhrasesModel], _ error: Error?) -> ()) {
        Service.shared.getAllTBL_Favorites_PhrasesModel() { (response, error) in
            if let listData = response{
                listLikePhrases.removeAll()
                listLikePhrases = listData
                DispatchQueue.main.async {}
            }
            completion(listLikePhrases, error)
        }
    }
    func isDark(Dark : Bool){
        if Dark == true {
            ChooseTab.tintColor = .black
            // MARK:
            if #available(iOS 13.0, *) {
                ChooseTab.selectedSegmentTintColor = .white
            } else {
                // Fallback on earlier versions
            }
            viewAll.backgroundColor = #colorLiteral(red: 0.04484110964, green: 0.01266181315, blue: 0.2235666436, alpha: 1)
            ChooseTab.backgroundColor = .white
            titlelable.textColor = .white
            wordsTable.backgroundColor = .black
        }
        else{
            ChooseTab.tintColor = .black
            // MARK:
            if #available(iOS 13.0, *) {
                ChooseTab.selectedSegmentTintColor = .white
            } else {
                // Fallback on earlier versions
            }
            viewAll.backgroundColor = .white
            ChooseTab.backgroundColor = .white
            titlelable.textColor = .black
            wordsTable.backgroundColor = .white
        }
    }
    @IBAction func Changetable(_ sender: Any) {
        switch ChooseTab.selectedSegmentIndex
            {
            case 0:
                choose = true
                wordsTable.reloadData()
            case 1:
                choose = false
                wordsTable.reloadData()
            default:
                break
            }
    }
}
extension BookMarkView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if choose==true { return listLikeWords.count}
        else {return listLikePhrases.count}
    }
    func tableView(_ tableView: UITableView,  cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.wordsTable.dequeueReusableCell(withIdentifier: "TableViewCellLearn", for: indexPath) as! TableViewCellLearn
        if choose==true {
            cell.imageStar.setBackgroundImage(UIImage(named : "ic_start_favourite_yellow"), for: .normal)
            cell.lableLearn.text = listLikeWords[indexPath.row].native_content
            cell.actionBlock = {
                let A : TBL_Favorites_WordsModel = TBL_Favorites_WordsModel(id: listLikeWords[indexPath.row].id , native_content: listLikeWords[indexPath.row].native_content, target_content: listLikeWords[indexPath.row].target_content, id_category: listLikeWords[indexPath.row].id_category, backgroud_img: listLikeWords[indexPath.row].backgroud_img)
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
            cell.lableLearn.text = listLikePhrases[indexPath.row].native_content
            cell.imageStar.setBackgroundImage(UIImage(named : "ic_start_favourite_yellow"), for: .normal)
            cell.actionBlock = {
                let A : TBL_Favorites_PhrasesModel = TBL_Favorites_PhrasesModel(id: listLikePhrases[indexPath.row].id , native_content: listLikePhrases[indexPath.row].native_content, target_content: listLikePhrases[indexPath.row].target_content, id_category: listLikePhrases[indexPath.row].id_category, backgroud_img: listLikePhrases[indexPath.row].backgroud_img)
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = wordsTable.cellForRow(at: indexPath) as! TableViewCellLearn
        if(choose == true){
            if cell.lableLearn.text == listLikeWords[indexPath.row].native_content{
                cell.view.backgroundColor = .red
                cell.lableLearn.textColor = UIColor.white
                cell.lableLearn.text = listLikeWords[indexPath.row].target_content
            }else {
                // MARK:
                if #available(iOS 13.0, *) {
                    cell.view.backgroundColor = UIColor.systemGray5
                } else {
                    cell.view.backgroundColor = .red
                    // Fallback on earlier versions
                }
                cell.lableLearn.text = listLikeWords[indexPath.row].native_content
                cell.lableLearn.textColor = UIColor.black
            }
        }
        else{
            if cell.lableLearn.text == listLikePhrases[indexPath.row].native_content{
                cell.view.backgroundColor = .red
                cell.lableLearn.textColor = UIColor.white
                cell.lableLearn.text = listLikePhrases[indexPath.row].target_content
            }else {
                // MARK:
                if #available(iOS 13.0, *) {
                    cell.view.backgroundColor = UIColor.systemGray5
                } else {
                    cell.view.backgroundColor = .red
                    // Fallback on earlier versions
                }
                cell.lableLearn.textColor = UIColor.black
                cell.lableLearn.text = listLikePhrases[indexPath.row].native_content
            }
        }
    }
    
}
