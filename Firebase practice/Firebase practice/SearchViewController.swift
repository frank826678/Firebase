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
    var displayMyFriendArray: [String] = []

    @IBOutlet weak var friendEmailTextInput: UITextField!
    
    @IBAction func addFriendBtn(_ sender: UIButton) {
        
        addFriend()
        
    }
    //var commentsArray: [String] = []
    //var anotherArr: [Int] = []
    
    //測試
    @IBAction func searchArticleBtnClick(_ sender: UIButton) {
        
        //readSpecifiedData()
        
        //showAlertWith(userId: "frank", friendKey: "fff", name: "Cccc")
        
    }
    
    //目前是否有人傳送邀請給我
    
    @IBAction func searchFriendAccept(_ sender: UIButton) {
        
        guard let useremil = UserManager.shared.getUserEmail() else { return }
        print(useremil)
        
        let myUserId2 = "frank826678_gmail_com"
        
        let myUserId = "frank826678@gmail.com"
        
        ref.child("user_database").child(myUserId2).child("friends").observe(.childAdded) { (snapshot) in
            
            let friendKey = snapshot.key
            
            guard let value = snapshot.value as? String else { return }
            if value == "發送邀請中"{
                return
            } else if value == "是否接受邀請" {
                
                //可以找朋友名字
                self.ref.child("user_database").child(snapshot.key).child("friends").observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    print(snapshot.value)
                    
                    print("---------")
                    //guard let name = snapshot.value as? String else { return }
                    
                    //self.showAlertWith(userId: userId, friendKey: friendKey, name: name)
                    
                    
                    //self.showAlertWith(myUserId: myUserId, myUserId2: myUserId2, friendEmail: <#T##String#>, Friendname: <#T##String#>)
                    
                })
            }
        }
        
    }
    
    
    //End
    
    
    @IBAction func searchTagBtnClick(_ sender: UIButton) {
        
        getSpecificTag()
        
    }
    
    @IBAction func searchFriendArticleBtnClick(_ sender: UIButton) {
    
        getSpecificFriendArticle()
    
    }
    
    
    @IBAction func displayAllFriend(_ sender: UIButton) {
        
        //假設目前使用者 需要新增 userdefault
        displayAllFriend()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        friendSendMessage()
        
        // Do any additional setup after loading the view.
        
        /*
         

         
        ref.child("user_database").queryOrdered(byChild: "email").queryEqual(toValue: friendEmail).observeSingleEvent(of: .value) { (snapshot) in
        let value = snapshot.value as? NSDictionary
        print(value as Any)
        guard value != nil else {
            print("使用者不存在")
            return
        }
        
        
        
        guard let valueKey = value?.allKeys[0] as? String else {
            print("沒拿到valueKey")
            return
        }
        */
        
        //start
        
//        let myUserId2 = "frank826678_gmail_com"
//
//        let myUserId = "frank826678@gmail.com"
        
//        self.ref.updateChildValues(["/user_database/\(valueKey)/friends/\(myUserId2)": ["accept": "是否接受邀請","friend_email": myUserId]])
//
//        //我發給別人 在自己的樹下 產生別人的名字然後發送邀請中
//        self.ref.updateChildValues(["/user_database/\(myUserId2)/friends/\(valueKey)": ["accept": "發送邀請中","friend_email": friendEmail]])
        

        
        
        //End
        //參考

        
//        ref.child("users").child(userId).child("contact").observe(.childAdded) { (snapshot) in
//            let friendKey = snapshot.key
//
//            guard let value = snapshot.value as? String else { return }
//            if value == "待邀請"{
//                return
//            } else if value == "待接受" {
//                self.ref.child("users").child(snapshot.key).child("name").observeSingleEvent(of: .value, with: { (snapshot) in
//                    print(snapshot.value)
//                    guard let name = snapshot.value as? String else { return }
//                    self.showAlertWith(userId: userId, friendKey: friendKey, name: name)
//                })
//            }
//    }
        
        
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
        
        //let tag = "rubysun137@hotmail.com"
        
        let tag = friendEmailTextInput.text
        
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
    
    func displayAllFriend() {
        
        //假設目前使用者 需要新增 userdefault
        
        let user = "frank826678_gmail_com"
        //queryOrdered(byChild: "friends").queryEqual(toValue: "friends")
        // queryOrdered 似乎只能搜尋一層
        
        //不太 OK
        //let postsByMostPopular = ref.child("user_database").child(user).queryOrdered(byChild: "friends")
        
        //displayMyFriendArray
        
        //let postsByMostPopular = ref.child("user_database").child(user).queryEqual(toValue: "friends")
        let postsByMostPopular = ref.child("user_database").child(user).child("friends")
        
        postsByMostPopular.observeSingleEvent(of: .value, with: { (snapshot)
            
            in
            
            //OK
            
            guard let value = snapshot.value as? NSDictionary else { return }
            
            print("以下為value資料")
            print(value)
            print("value資料結束")
            //let friendsNumber =  value.value(forKey: "friends")
            
            //print(friendsNumber)
            let allkeyCount = value.allKeys.count
            print(allkeyCount)
            
            print("------")
            //let key = value?.allKeys.first
            for index in 0 ..< allkeyCount {
                //guard let member = value[value.allKeys[0]] as? NSDictionary else { return }
                //guard let member = value[value.allKeys[index]] as? NSDictionary else { return }
                
                guard let allFriends = value.allKeys[index] as? String else { return }
                
                
//                guard let articleTitle = member["article_title"] as? String else { return }
                
                print("以下為allFriends資料")
                
                print(allFriends)
                
                self.displayMyFriendArray.append(allFriends)
                
                print("allFriends資料結束")
                
            }
            
            print("----------------")
            print("所有 friendArticle 資料 \(self.displayMyFriendArray)")
            
            
            
        })
        
    }
    
    func addFriend() {
        
        guard let friendEmail = friendEmailTextInput.text else { return }
        
//        let str = friendEmail
//        let replaced = str.replacingOccurrences(of: "@", with: "_")
//        let notSureFriend = replaced.replacingOccurrences(of: ".", with: "_")
        
        //可以使用 userdefault
        //guard let myId = "frank826678_gmail_com" else { return }
        
        let myUserId2 = "frank826678_gmail_com"
        
        let myUserId = "frank826678@gmail.com"
        
        // kazjiay@gmail.com kazjiay_gmail_com
       //ref.child("user_database").child(myUserId).child("friends").child(notSureFriend).child("accept").setValue("好友")
        
        
        
                ref.child("user_database").queryOrdered(byChild: "email").queryEqual(toValue: friendEmail).observeSingleEvent(of: .value) { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                    print(value as Any)
                    guard value != nil else {
                        print("使用者不存在")
                        return
                    }
                    

        
                    guard let valueKey = value?.allKeys[0] as? String else {
                        print("沒拿到valueKey")
                        return
                    }
                    
                    //print("valueKey是\(valueKey)")
                    
//                    self.ref.updateChildValues(["/user_database/\(valueKey)/friends/\(myUserId)": "是否接受邀請"])
//                    self.ref.updateChildValues(["/user_database/\(myUserId)/friends/\(valueKey)": "發送邀請中"])
                    
                    self.ref.updateChildValues(["/user_database/\(valueKey)/friends/\(myUserId2)": ["accept": "是否接受邀請","friend_email": myUserId]])
                    
                    //我發給別人 在自己的樹下 產生別人的名字然後發送邀請中
                    self.ref.updateChildValues(["/user_database/\(myUserId2)/friends/\(valueKey)": ["accept": "發送邀請中","friend_email": friendEmail]])
                    
                    self.friendEmailTextInput.text = ""
                    
        }
        
       
        
        //let postsByMostPopular = ref.child("user_database").child(myUserId).child("friends")
        
  
        
       //.queryEqual(toValue: "好友")
        
        
//        ref.child("user_database").child(myUserId).queryOrdered(byChild: "friends").queryEqual(toValue: "kazjiay@gmail.com").observeSingleEvent(of: .value) { (snapshot) in
//            let value = snapshot.value as? NSDictionary
//
//            print("拿到的value是\(value)")
//            //print(value as Any)
//
//            guard value != nil else {
//                print("User doesn't exist!")
//                return
//            }
//        }
        
        
        //ref.child(<#T##pathString: String##String#>)
        
        
   
        
//        guard let email = friendsEmailText.text else { return }
//        guard let userId = UserManager.shared.getUserId() else { return }
//
//        ref.child("users").queryOrdered(byChild: "email").queryEqual(toValue: email).observeSingleEvent(of: .value) { (snapshot) in
//            let value = snapshot.value as? NSDictionary
//            print(value as Any)
//            guard value != nil else {
//                print("User doesn't exist!")
//                return
//            }
//
//            guard let valueKey = value?.allKeys[0] as? String else {
//                return
//            }
//            self.ref.updateChildValues(["/users/\(valueKey)/contact/\(userId)": "待接受"])
//            self.ref.updateChildValues(["/users/\(userId)/contact/\(valueKey)": "待邀請"])
//
//            self.friendsEmailText.text = ""
//        }
        
    
    }
    
    func friendSendMessage() {
        
        //guard let useremail = UserManager.shared.getUserEmail() else { return }
        //print(useremail)
        
        let myUserId2 = "frank826678_gmail_com"
        
        let myUserId = "frank826678@gmail.com"
        
        //observe(.childAdded)
        
        ref.child("user_database").child(myUserId2).child("friends").observe(.childChanged) { (snapshot) in
            
            //demo 用
            self.showAlertWith(myUserId: myUserId, myUserId2: myUserId2, friendEmail: "RUBY@gmail.com", Friendname: "RUBY")
            
            let friendKey = snapshot.value
            print(snapshot)
            print("測試friendKey\(friendKey)") //Keykazjiay_gmail_com
            
            
            
//            let value = snapshot.value as? NSDictionary
//            print(value as Any)
//            guard value != nil else {
//                print("使用者不存在")
//                return
//            }
            
//            Snap (kazjiay_gmail_com) {
//                accept = "\U662f\U5426\U63a5\U53d7223";
//                "friend_email" = "kazjiay@gmail.com";
//            }
//            測試friendKeykazjiay_gmail_com
            
            //let dictvalue = snapshot as! NSDictionary
            //let acceptValue =
            
            guard let value = snapshot.value as? String else { return }
            
            print("裡面的值是\(value)")
            print("--------------")
            
            
            if value == "是否接受邀請"{
                //可以找朋友名字
                self.ref.child("user_database").child(snapshot.key).child("friends").observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    print(snapshot.value)
                    
                    print("---------")
                    //guard let name = snapshot.value as? String else { return }
                    
                    //self.showAlertWith(userId: userId, friendKey: friendKey, name: name)
                    
                    //應該放的位置
                    //self.showAlertWith(myUserId: myUserId, myUserId2: myUserId2, friendEmail: <#T##String#>, Friendname: <#T##String#>)
                    
                })
            } else if value == "發送邀請中" {
                
                return
                //
            }
        }
        
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

extension SearchViewController {
    
    func showAlertWith(myUserId: String,myUserId2: String ,friendEmail: String, Friendname: String) {
        let alerController = UIAlertController(title: "新朋友邀請", message: "\(Friendname) 傳送好友邀請給您!" , preferredStyle: .alert)
        alerController.addAction(UIAlertAction(title: "拒絕", style: .default, handler: { (_) in
            //self.ref.updateChildValues(["/users/\(userId)/contact/\(friendKey)": false])
            //self.ref.updateChildValues(["/users/\(friendKey)/contact/\(userId)": false])
        }))
        alerController.addAction(UIAlertAction(title: "同意", style: .default, handler: { (_) in
            
            self.ref.updateChildValues(["/user_database/\(friendEmail)/friends/\(myUserId2)": ["accept": "好友","friend_email": myUserId]])
            
            //我發給別人 在自己的樹下 產生別人的名字然後發送邀請中
            self.ref.updateChildValues(["/user_database/\(myUserId2)/friends/\(friendEmail)": ["accept": "好友","friend_email": friendEmail]])
            
        }))
        self.present(alerController, animated: true, completion: nil)
    }
}

