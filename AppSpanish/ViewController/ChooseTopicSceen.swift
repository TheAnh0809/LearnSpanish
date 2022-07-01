//
//  ViewControllerSceen3.swift
//  SpanishApp
//
//  Created by Shi Ying Nguyen on 08/01/2021.
//

import UIKit
import SQLite
import Localize_Swift
extension NSObject {
    func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }
    var className: String {
        return String(describing: type(of: self))
    }
    class var className: String {
        return String(describing: self)
    }
}

class ChooseTopic: UIViewController {
    @IBOutlet var viewAll: UIView!
    @IBOutlet weak var lable1: UILabel!
    @IBOutlet weak var lable2: UILabel!
    @IBOutlet weak var lable3: UILabel!
    @IBOutlet weak var Tabbutton: UIButton!
    var idTopic : Int?
    var nameSQL : String!
    var linkSQL : String!
    @IBOutlet weak var CLVChosselesson: UICollectionView!
    @IBOutlet weak var TextSearch: UITextField!
    var search : String!
    var listLensson : [TBL_CategoriseModel] = [TBL_CategoriseModel]()
    var listDem : [TBL_CategoriseModel] = [TBL_CategoriseModel]()
    var list : [TBL_CategoriseModel] = [TBL_CategoriseModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        lable1.text = "Learn Spanish".localized()
        lable2.text = "Select a topic\nyou want to learn".localized()
        lable3.text = "To start learning Spanish effectively!".localized()
        CLVChosselesson.register(UINib(nibName: "CellChossceLesson", bundle: nil), forCellWithReuseIdentifier: "CellChossceLesson")
        CLVChosselesson.delegate = self
        CLVChosselesson.dataSource = self
        
        CLVChosselesson.layer.cornerRadius = 15.0
        
        nameSQL = String(UserDefaults.standard.string(forKey: "db")!)
        linkSQL = nameSQL + ".db"
        self.getDataCatagories(){_,_ in
        }
        listLensson.sort { (A, B) -> Bool in
            return A.name < B.name
        }
        var cellWidth = 0
        if UIDevice.current.userInterfaceIdiom == .pad {
            cellWidth = Int(UIScreen.main.bounds.width)
        } else {
            cellWidth = Int(UIScreen.main.bounds.width)
        }
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: cellWidth, height: (cellWidth * 120) / 90)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        flowLayout.minimumInteritemSpacing = 0.0
        CLVChosselesson.collectionViewLayout = flowLayout
        
        
        TextSearch.attributedPlaceholder = NSAttributedString(string: "Search ?".localized(),
                                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        TextSearch.layer.cornerRadius = 10.0
        TextSearch.layer.borderWidth = 1.0
        TextSearch.layer.borderColor = UIColor.white.cgColor
        TextSearch.textColor = UIColor.white
        
        TextSearch.addTarget(self, action: #selector(ChooseTopic.textFieldDidChange(_:)),for: .editingChanged)
        listDem = listLensson
        isDark(Dark: isdark)
    }
    func isDark(Dark : Bool){
        if Dark == true {
            TextSearch.attributedPlaceholder = NSAttributedString(string: "Search ?".localized(),
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            TextSearch.backgroundColor = .darkGray
            TextSearch.textColor = .black
            viewAll.backgroundColor = #colorLiteral(red: 0.04484110964, green: 0.01266181315, blue: 0.2235666436, alpha: 1)
            self.lable1.textColor = .black
            self.lable2.textColor = .black
            lable3.textColor = .black
            CLVChosselesson.backgroundColor = #colorLiteral(red: 0.04484110964, green: 0.01266181315, blue: 0.2235666436, alpha: 1)
            Tabbutton.setBackgroundImage(#imageLiteral(resourceName: "Group 1"), for: .normal)
        }
        else{
            TextSearch.attributedPlaceholder = NSAttributedString(string: "Search ?".localized(),
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            TextSearch.textColor = .white
            TextSearch.backgroundColor = .systemPink
            viewAll.backgroundColor = .white
            self.lable1.textColor = .white
            self.lable2.textColor = .white
            lable3.textColor = .white
            CLVChosselesson.backgroundColor = .white
            Tabbutton.setBackgroundImage(#imageLiteral(resourceName: "whiteTab"), for: .normal)
        }
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        search = TextSearch.text
        let B : String!
        if search.count >= 1 {
            B = String( search.last! )
        }
        else{
            B = search
        }
        if list.count > 0{
            listLensson = list
        }
        else {
            listLensson = listDem
        }
        list.removeAll()
        for item in listLensson {
            let A : String = item.name.filter{B.contains($0)}
            if A != "" {
                list.append(item)
            }
        }
        if search == "" {
            listLensson = listDem
        }
        else {
            listLensson = list
        }
        CLVChosselesson.reloadData()
    }
    func getDataCatagories(andCompletion completion:@escaping (_ moviesResponse: [TBL_CategoriseModel], _ error: Error?) -> ()) {
        Service.shared.initDB(A: nameSQL, B: nameSQL + ".db")
        Service.shared.getDataCategory() { (response, error) in
            if let listData = response{
                self.listLensson.removeAll()
                self.listLensson = listData
                DispatchQueue.main.async {}
            }
            completion(self.listLensson, error)
        }
    }
}
extension ChooseTopic: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listLensson.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CLVChosselesson.dequeueReusableCell(withReuseIdentifier: CellChossceLesson.className, for: indexPath) as! CellChossceLesson
        cell.lableNameTopic.text =  listLensson[indexPath.row].name
        cell.lableTopic.text = "Topic".localized() + String(listLensson[indexPath.row].id)
        cell.imageCell.image = UIImage(named: listLensson[indexPath.row].image_name)
        
        cell.prosetView.progress = Float(Double.random(in: 0..<1))
        cell.prosetView.tintColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        return UICollectionReusableView()
    }
    
}
extension ChooseTopic: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad{
            return CGSize(width: UIScreen.main.bounds.width, height: 150)
        }
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc:LearnSceen = storyboard.instantiateViewController(withIdentifier: "LearnSceen") as! LearnSceen
        vc.modalPresentationStyle = .fullScreen
        vc.idTopic = listLensson[indexPath.row].id
        idTopic = listLensson[indexPath.row].id
        self.present(vc, animated: true,completion: nil)
    }
}
