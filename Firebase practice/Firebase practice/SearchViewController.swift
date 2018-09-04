//
//  SearchViewController.swift
//  Firebase practice
//
//  Created by Frank on 2018/9/4.
//  Copyright © 2018 Frank. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class SearchViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    var ref: DatabaseReference!
    //var commentsArray = [String]()
    
    var tagArray: [String] = []
    var friendArticleArray: [String] = []
    
    //var commentsArray: [String] = []
    //var anotherArr: [Int] = []
    
    @IBAction func searchArticleBtnClick(_ sender: UIButton) {
        
        readSpecifiedData()
        
        
    }
    
    
    @IBAction func searchTagBtnClick(_ sender: UIButton) {
        
        getSpecificTag()
        
    }
    
    @IBAction func searchFriendArticleBtnClick(_ sender: UIButton) {
    
        getSpecificFriendArticle()
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDataToLocal() {
        
        let keyWord = "生活"
        //let keyWord = "ybYLaENWESY3KRbPzo95XNG7RCv2"
        
        // queryOrdered 似乎只能搜尋一層
        let commentsRef = ref.child("article_database").queryOrdered(byChild: "article_tag").queryEqual(toValue: keyWord)
        
        // Listen for new comments in the Firebase database
        commentsRef.observe(.childAdded, with: { (snapshot) -> Void in
            
            //commentsArray.append(snapshot)
            
            //self.tableView.insertRows(at: [IndexPath(row: self.comments.count-1, section: self.kSectionComments)], with: UITableViewRowAnimation.automatic)
        })
        
    }
    
    func getSpecificTag() {
        
        let tag = "八卦"
        
        //let keyWord = "生活"
        //let keyWord = "ybYLaENWESY3KRbPzo95XNG7RCv2"
        
        // queryOrdered 似乎只能搜尋一層
        let postsByMostPopular = ref.child("article_database").queryOrdered(byChild: "article_tag").queryEqual(toValue: tag)
        
        //"article_tag"
        
        postsByMostPopular.observeSingleEvent(of: .value, with: { (snapshot)
            
            in
            
            //OK
            
            guard let value = snapshot.value as? NSDictionary else { return }
            
            print("以下為value資料")
            print(value)
            print("value資料結束")
            
             let allkeyCount = value.allKeys.count
            
            //let key = value?.allKeys.first
            for index in 0 ..< allkeyCount {
            //guard let member = value[value.allKeys[0]] as? NSDictionary else { return }
            guard let member = value[value.allKeys[index]] as? NSDictionary else { return }
             
            guard let articleTitle = member["article_title"] as? String else { return }
            
            print("以下為articleTitle資料")
            
            print(articleTitle)
            
                self.tagArray.append(articleTitle)
                
            print("articleTitle資料結束")
                
            }
            
            print("----------------")
            print("所有 title 資料 \(self.tagArray)")

            
            //let key = value![0] as! [String: Any]
            
            //let dictionaryResult = value![key]
            
           // print(dictionary["article_tag"])
            
            //if let value = snapshot.value as? NSDictionary
            //print(value)
            
//            guard let dictionary = snapshot.value as? [String: Any] else {
//                return
//            }
            
//            guard let statusDictionary = dictionary["article_tag"] as? [String: Any] else {
//                return
//            }
            
//            let articleData = Article()
//
//            articleData.displayTag = dictionary["article_tag"] as? String
//
           // print("以下為displayTag資料")
            
            //print(dictionary["article_tag"])
            //print(articleData.displayTag)
            
            //print("displayTag資料結束")
            
//             print(dictionary)
//            print(articleData.displayTag)
//            print("------------")
            
            
            
            //print(value.allKeys[0])
            
            //print("找到的資料是\(snapshot)")
            //let a = snapshot.value as! NSDictionary
            //print("奇怪東西\(a)")
            
            
        })
        
//        ref.child("user_database").child(replaced2).observeSingleEvent(of: .value) { (snapshot) in
//            // Get user value
//
//
//
//            guard let value = snapshot.value as? NSDictionary else { return self.searchEmailResultLabel.text = "找不到資料" }
//
//            guard let userName = value["name"] as? String else { return }
//
//
//            guard let userEmail = value["email"] as? String else { return }
//
//
//            guard let userUid = value["uid"] as? String else { return }
//
//            print(userName)
//            print(userEmail)
//            print(userUid)
//
//            self.searchEmailResultLabel.text = ("名字:\(userName)。Email是:\(userEmail)。UID是:\(userUid)")
//            //self.searchEmailResultLabel.text = ("找到UID為\(userUid)")
//
//        }
        
    }
    
    func getSpecificFriendArticle() {
        
        let tag = "rubysun137@hotmail.com"
        
        // queryOrdered 似乎只能搜尋一層
        let postsByMostPopular = ref.child("article_database").queryOrdered(byChild: "email").queryEqual(toValue: tag)
        
        //"article_tag"
        
        postsByMostPopular.observeSingleEvent(of: .value, with: { (snapshot)
            
            in
            
            //OK
            
            guard let value = snapshot.value as? NSDictionary else { return }
            
            print("以下為value資料")
            print(value)
            print("value資料結束")
            
            let allkeyCount = value.allKeys.count
            
            //let key = value?.allKeys.first
            for index in 0 ..< allkeyCount {
                //guard let member = value[value.allKeys[0]] as? NSDictionary else { return }
                guard let member = value[value.allKeys[index]] as? NSDictionary else { return }
                
                guard let articleTitle = member["article_title"] as? String else { return }
                
                print("以下為articleTitle資料")
                
                print(articleTitle)
                
                self.friendArticleArray.append(articleTitle)
                
                print("articleTitle資料結束")
                
            }
            
            print("----------------")
            print("所有 friendArticle 資料 \(self.friendArticleArray)")
            

        
        })
        
        //resultLabel.text = friendArticleArray
    }

    
    func getSpecificFriendTagArticle() {
        
    }

    func readSpecifiedData() {
        
        //        ref.child("article_database").child("article_id").observeSingleEvent(of: .value, with: { (snapshot) in
        //
        //            print("找到的資料是\(snapshot)")
        //
        //        }) { (error) in
        //            print(error.localizedDescription)
        //        }
        
        //article_tag:
        
        //        let username = "SomeUser"
        //
        //        FIRDatabase.database().reference.child("users").queryOrderedByChild("username").queryStartingAtValue(username).queryEndingAtValue(username).observeEventType(.ChildAdded, withBlock: { (snapshot) -> Void in
        //
        //        }
        
        let keyWord = "生活"
        //let keyWord = "ybYLaENWESY3KRbPzo95XNG7RCv2"
        
        // queryOrdered 似乎只能搜尋一層
        let postsByMostPopular = ref.child("article_database").queryOrdered(byChild: "article_tag").queryEqual(toValue: keyWord)
        
        //"article_tag"
        
        postsByMostPopular.observeSingleEvent(of: .value, with: { (snapshot)
            
            in
            
            print("找到的資料是\(snapshot)")
            
            let a = snapshot.value as! NSDictionary
            print("奇怪東西\(a)")
            
        })
        
        
    }

}

//guard let dictionary = snapshot.value as? [String: Any] else {
//    return
//}
//
//guard let statusDictionary = dictionary["status"] as? [String: Any] else {
//    return
//}
//
//guard let deviceStatusDictionary = statusDictionary["DEVICE_KEY"] as? [String: Any] else {
//    return
//}
//
//let user = User()
//
//user.displayname = dictionary["displayname"] as? String
//user.isconnected = deviceStatusDictionary["isconnected"] as? Bool

//class User: NSObject {
//    var displayname: String?
//    var isconnected: Bool?
//}

class Article: NSObject {
    var displayTag: String?
    var displayArticleContent: String?
    //var isconnected: Bool?
}

