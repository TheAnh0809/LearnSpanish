//
//  Service.swift
//  SpanishApp
//
//  Created by Shi Ying Nguyen on 06/01/2021.
//
import SQLite
import UIKit
import SQLite3


class Service :NSObject{
    var dataTBL_CategoriseModel = [TBL_CategoriseModel]()
    var dataTBL_WordsModel = [TBL_WordsModel]()
    var dataTBL_PhrasesModel = [TBL_PhrasesModel]()
    var dataV_PhrasesWordsModel = [V_PhrasesWordsModel]()
    var dataTBL_Favorites_WordsModel = [TBL_Favorites_WordsModel]()
    var dataTBL_Favorites_PhrasesModel = [TBL_Favorites_PhrasesModel]()
    var dataV_PhrasesModel = [A_PhrasesModel]()
    var dataV_WordsModel = [A_WordsModel]()
    static let shared: Service = Service()
    var dataAll = [String:[TBL_CategoriseModel]]()
    var DatabaseRoot:Connection?
    func initDB (A : String!, B : String!) {
            let dbURL = Bundle.main.url(forResource: A, withExtension: "db")!
            var newURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            newURL.appendPathComponent(B)
            do {
                if !FileManager.default.fileExists(atPath: newURL.path) {
                    try FileManager.default.copyItem(atPath: dbURL.path, toPath: newURL.path)
                }
            } catch {
                print(error.localizedDescription)
            }
            do {
                DatabaseRoot = try Connection(newURL.path)
            } catch {
                DatabaseRoot = nil
                let nserr = error as NSError
                print("Cannot connect to Database. Error is: \(nserr), \(nserr.userInfo)")
            }
        }
    
    
    func getDataCategory(closure: @escaping (_ response: [TBL_CategoriseModel]?, _ error: Error?) -> Void) {
        let users = Table("tbl_categories")
        let id = Expression<Int64>("_id")
        let name = Expression<String?>("name")
        let imagename = Expression<String?> ("image_name")
        let imageinfo = Expression<String?> ("image_info")
        dataTBL_CategoriseModel.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for user in try DatabaseRoot.prepare(users) {
                    dataTBL_CategoriseModel.append(TBL_CategoriseModel(id: Int(user[id]), name: user[name]!,
                                    image_name: user[imagename]!, image_info: user[imageinfo]!))
                    
                }
            } catch  {
                print("Loi Loi mat")
                return
            }
            
        }
        closure(dataTBL_CategoriseModel, nil)
    }
    func getTBL_WordsModel(closure: @escaping (_ response: [TBL_WordsModel]?, _ error: Error?) -> Void) {
        let users = Table("tbl_words")
        let id = Expression<Int64>("_id")
        let native_content = Expression<String?>("native_content")
        let target_content = Expression<String?> ("target_content")
        let backgroud_img = Expression<String?> ("background_img")
        let id_category = Expression<Int64>("id_category")
        
        dataTBL_WordsModel.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for user in try DatabaseRoot.prepare(users) {
                    dataTBL_WordsModel.append(TBL_WordsModel(id: Int(user[id]), native_content: user[native_content]!,
                  target_content: user[target_content]!, id_category : Int(user[id_category]),  backgroud_img: user[backgroud_img]!))
                    
                }
            } catch  {
                print("Loi Loi mat")
                return
            }
            
        }
        closure(dataTBL_WordsModel, nil)
    }
    func getTBL_PhrasesModel(closure: @escaping (_ response: [TBL_PhrasesModel]?, _ error: Error?) -> Void) {
        let users = Table("tbl_phrases")
        let id = Expression<Int64>("_id")
        let native_content = Expression<String?>("native_content")
        let target_content = Expression<String?> ("target_content")
        let backgroud_img = Expression<String?> ("background_img")
        let id_category = Expression<Int64>("id_category")
        
        dataTBL_PhrasesModel.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for user in try DatabaseRoot.prepare(users) {
                    dataTBL_PhrasesModel.append(TBL_PhrasesModel(id: Int(user[id]), native_content: user[native_content]!,
                  target_content: user[target_content]!, id_category : Int(user[id_category]),  backgroud_img: user[backgroud_img]!))
                    
                }
            } catch  {
                print("Loi Loi mat")
                return
            }
            
        }
        closure(dataTBL_PhrasesModel, nil)
    }
    func getTBL_Favorites_WordsModel(A : Int?, closure: @escaping (_ response: [TBL_Favorites_WordsModel]?, _ error: Error?) -> Void) {
        let users = Table("tbl_favorites_words")
        let id = Expression<Int64>("_id")
        let native_content = Expression<String?>("native_content")
        let target_content = Expression<String?> ("target_content")
        let backgroud_img = Expression<String?> ("background_img")
        let id_category = Expression<Int64>("id_category")
        var dataList : [TBL_Favorites_WordsModel] = [TBL_Favorites_WordsModel]()
        dataTBL_Favorites_WordsModel.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for user in try DatabaseRoot.prepare(users) {
                    dataList.append(TBL_Favorites_WordsModel(id: Int(user[id]), native_content: user[native_content]!,
                  target_content: user[target_content]!, id_category : Int(user[id_category]),  backgroud_img: user[backgroud_img]!))
                }
                for i in dataList{
                    if i.id_category == A{
                        dataTBL_Favorites_WordsModel.append(i)
                    }
                }
            } catch  {
                print("Loi Loi mat")
                return
            }
            
        }
        closure(dataTBL_Favorites_WordsModel, nil)
    }
    func getAllTBL_Favorites_WordsModel( closure: @escaping (_ response: [TBL_Favorites_WordsModel]?, _ error: Error?) -> Void) {
        let users = Table("tbl_favorites_words")
        let id = Expression<Int64>("_id")
        let native_content = Expression<String?>("native_content")
        let target_content = Expression<String?> ("target_content")
        let backgroud_img = Expression<String?> ("background_img")
        let id_category = Expression<Int64>("id_category")
        var dataList : [TBL_Favorites_WordsModel] = [TBL_Favorites_WordsModel]()
        dataTBL_Favorites_WordsModel.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for user in try DatabaseRoot.prepare(users) {
                    dataList.append(TBL_Favorites_WordsModel(id: Int(user[id]), native_content: user[native_content]!,
                  target_content: user[target_content]!, id_category : Int(user[id_category]),  backgroud_img: user[backgroud_img]!))
                }
                for i in dataList{
                        dataTBL_Favorites_WordsModel.append(i)
                }
            } catch  {
                print("Loi Loi mat")
                return
            }
            
        }
        closure(dataTBL_Favorites_WordsModel, nil)
    }
    func insert_TBL_Favorites_WordsModel(dataInsert : TBL_Favorites_WordsModel) {
        let users = Table("tbl_favorites_words")
        let id = Expression<Int64>("_id")
        let native_content = Expression<String?>("native_content")
        let target_content = Expression<String?> ("target_content")
        let backgroud_img = Expression<String?> ("background_img")
        let id_category = Expression<Int64>("id_category")
        if let db = DatabaseRoot{
            do {
                try db.run(users.insert( id <- Int64(dataInsert.id!) , native_content <- dataInsert.native_content , target_content <- dataInsert.target_content, id_category <- Int64(dataInsert.id_category!) , backgroud_img <- dataInsert.backgroud_img))
                print(users.count)
            }
            catch {
                print("Insert error")
                return
            }
        }
    }
    func delete_TBL_Favorites_WordsModel(dataInsert : TBL_Favorites_WordsModel) {
        let users = Table("tbl_favorites_words")
        let id = Expression<Int64>("_id")
        if let db = DatabaseRoot{
            do {
                let user = users.filter(id == Int64(dataInsert.id!))
                try db.run(user.delete())
            }
            catch {
                print("Delete error")
                return
            }
        }
    }
    func getTBL_Favorites_PhrasesModel(A : Int?, closure: @escaping (_ response: [TBL_Favorites_PhrasesModel]?, _ error: Error?) -> Void) {
        let users = Table("tbl_favorites_phrases")
        let id = Expression<Int64>("_id")
        let native_content = Expression<String?>("native_content")
        let target_content = Expression<String?> ("target_content")
        let backgroud_img = Expression<String?> ("background_img")
        let id_category = Expression<Int64>("id_category")
        var dataList : [TBL_Favorites_PhrasesModel] = [TBL_Favorites_PhrasesModel]()
        dataTBL_Favorites_PhrasesModel.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for user in try DatabaseRoot.prepare(users) {
                    dataList.append(TBL_Favorites_PhrasesModel(id: Int(user[id]), native_content: user[native_content]!,
                  target_content: user[target_content]!, id_category : Int(user[id_category]),  backgroud_img: user[backgroud_img]!))
                    
                }
                for i in dataList{
                    if i.id_category == A{
                        dataTBL_Favorites_PhrasesModel.append(i)
                    }
                }
            } catch  {
                print("Loi Loi mat")
                return
            }
            
        }
        closure(dataTBL_Favorites_PhrasesModel, nil)
    }
    func getAllTBL_Favorites_PhrasesModel( closure: @escaping (_ response: [TBL_Favorites_PhrasesModel]?, _ error: Error?) -> Void) {
        let users = Table("tbl_favorites_phrases")
        let id = Expression<Int64>("_id")
        let native_content = Expression<String?>("native_content")
        let target_content = Expression<String?> ("target_content")
        let backgroud_img = Expression<String?> ("background_img")
        let id_category = Expression<Int64>("id_category")
        var dataList : [TBL_Favorites_PhrasesModel] = [TBL_Favorites_PhrasesModel]()
        dataTBL_Favorites_PhrasesModel.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for user in try DatabaseRoot.prepare(users) {
                    dataList.append(TBL_Favorites_PhrasesModel(id: Int(user[id]), native_content: user[native_content]!,
                  target_content: user[target_content]!, id_category : Int(user[id_category]),  backgroud_img: user[backgroud_img]!))
                }
                for i in dataList{
                        dataTBL_Favorites_PhrasesModel.append(i)
                }
            } catch  {
                print("Loi Loi mat")
                return
            }
            
        }
        closure(dataTBL_Favorites_PhrasesModel, nil)
    }
    func insert_TBL_Favorites_PhrasesModel(dataInsert : TBL_Favorites_PhrasesModel) {
        let users = Table("tbl_favorites_phrases")
        let id = Expression<Int64>("_id")
        let native_content = Expression<String?>("native_content")
        let target_content = Expression<String?> ("target_content")
        let backgroud_img = Expression<String?> ("background_img")
        let id_category = Expression<Int64>("id_category")
        if let db = DatabaseRoot{
            do {
                try db.run(users.insert( id <- Int64(dataInsert.id!) , native_content <- dataInsert.native_content , target_content <- dataInsert.target_content, id_category <- Int64(dataInsert.id_category!) , backgroud_img <- dataInsert.backgroud_img))

            }
            catch {
                print("Insert error")
                return
            }
        }
    }
    func delete_TBL_Favorites_PhrasesModel(dataInsert : TBL_Favorites_PhrasesModel) {
        let users = Table("tbl_favorites_phrases")
        let id = Expression<Int64>("_id")
        if let db = DatabaseRoot{
            do {
                let user = users.filter(id == Int64(dataInsert.id!))
                try db.run(user.delete())
            }
            catch {
                print("Delete error")
                return
            }
        }
    }
    func getV_WordsModel(A : Int?, closure: @escaping (_ response: [A_WordsModel]?, _ error: Error?) -> Void) {
        let users = Table("v_words")
        let id = Expression<Int64>("_id")
        let native_content = Expression<String?>("native_content")
        let target_content = Expression<String?> ("target_content")
        let id_category = Expression<Int64>("id_category")
        let backgroud_img = Expression<String?> ("background_img")
        let content_type = Expression<String?>("content_type")
        let has_favorites = Expression<String?>("has_favorites")
        var dataList : [A_WordsModel] = [A_WordsModel]()
        dataV_WordsModel.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for user in try DatabaseRoot.prepare(users) {
                    
                    dataList.append(A_WordsModel(id: Int(user[id]), native_content: user[native_content], target_content: user[target_content], id_category: Int(user[id_category]), backgroud_img: user[backgroud_img], content_type: user[content_type], has_favorites: user[has_favorites]))
                    
                }
                for i in dataList{
                    if i.id_category == A{
                        dataV_WordsModel.append(i)
                    }
                }
            } catch  {
                print("Loi Loi mat")
                return
            }
            
        }
        closure(dataV_WordsModel, nil)
    }
    func getA_PhrasesModel(A : Int?, closure: @escaping (_ response: [A_PhrasesModel]?, _ error: Error?) -> Void) {
        let users = Table("v_phrases")
        let id = Expression<Int64>("_id")
        let native_content = Expression<String?>("native_content")
        let target_content = Expression<String?> ("target_content")
        let backgroud_img = Expression<String?> ("background_img")
        let id_category = Expression<Int64>("id_category")
        let content_type = Expression<String?>("content_type")
        let has_favorites = Expression<String?>("has_favorites")
        var dataList : [A_PhrasesModel] = [A_PhrasesModel]()
        dataV_PhrasesModel.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for user in try DatabaseRoot.prepare(users) {
                    dataList.append(A_PhrasesModel(id: Int(user[id]), native_content: user[native_content], target_content: user[target_content],
                                                             id_category: Int(user[id_category]), backgroud_img: user[backgroud_img],
                                                             content_type: user[content_type], has_favorites: user[has_favorites]))
                }
                for i in dataList{
                    if i.id_category == A{
                        dataV_PhrasesModel.append(i)
                    }
                }
            } catch  {
                print("Loi Loi mat")
                return
            }
            
        }
        closure(dataV_PhrasesModel, nil)
    }
    func getV_PhrasesWordsModel(closure: @escaping (_ response: [V_PhrasesWordsModel]?, _ error: Error?) -> Void) {
        let users = Table("v_phrases_words")
        let id = Expression<Int64>("_id")
        let native_content = Expression<String?>("native_content")
        let target_content = Expression<String?> ("target_content")
        let backgroud_img = Expression<String?> ("background_img")
        let id_category = Expression<Int64>("id_category")
        let content_type = Expression<String?>("content_type")
        let has_favorites = Expression<String?>("has_favorites")
        
        dataV_PhrasesWordsModel.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for user in try DatabaseRoot.prepare(users) {
                    
                    dataV_PhrasesWordsModel.append(V_PhrasesWordsModel(id: Int(user[id]), native_content: user[native_content], target_content: user[target_content], id_category: Int(user[id_category]), backgroud_img: user[backgroud_img], content_type: user[content_type], has_favorites: user[has_favorites]))
                    
                }
            } catch  {
                print("Loi Loi mat")
                return
            }
            
        }
        closure(dataV_PhrasesWordsModel, nil)
    }
}
