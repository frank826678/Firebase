//
//  ViewController.swift
//  Firebase practice
//
//  Created by Frank on 2018/9/3.
//  Copyright © 2018 Frank. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

//ybYLaENWESY3KRbPzo95XNG7RCv2
//frank826678@gmail.com


class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextInput: UITextField!
    
    @IBOutlet weak var passwordTextInput: UITextField!
    
    
    @IBOutlet weak var searchEmailResultLabel: UILabel!
    
    @IBOutlet weak var friendTextInput: UITextField!
    
    var ref: DatabaseReference!
    
    //ref = Database.database().reference()
    //Expected declaration
    
    
    @IBAction func addArticleBtnClick(_ sender: UIButton) {
        
        createData()
        
    }
    
    @IBAction func logInBtnClick(_ sender: UIButton) {
        
        
        //let ref = Database.database().reference()
        
        //login()
        
        //createData()
        
        //OK
        //readData()
        
        readSpecifiedData()
        
    }
    
    
    @IBAction func searchEmailBtnClick(_ sender: UIButton) {
        
        //readSpecifiedData()
        readEmailToUid()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ref = Database.database().reference()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //        // [START auth_listener]
    //        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
    //            // [START_EXCLUDE]
    //            self.setTitleDisplay(user)
    //            self.tableView.reloadData()
    //            // [END_EXCLUDE]
    //        }
    //        // [END auth_listener]
    //    }
    
    //    @IBAction func didTapEmailLogin(_ sender: AnyObject) {
    //        if let email = self.emailField.text, let password = self.passwordField.text {
    //            showSpinner {
    //                // [START headless_email_auth]
    //                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
    //                    // [START_EXCLUDE]
    //                    self.hideSpinner {
    //                        if let error = error {
    //                            self.showMessagePrompt(error.localizedDescription)
    //                            return
    //                        }
    //                        self.navigationController!.popViewController(animated: true)
    //                    }
    //                    // [END_EXCLUDE]
    //                }
    //                // [END headless_email_auth]
    //            }
    //        } else {
    //            self.showMessagePrompt("email/password can't be empty")
    //        }
    //    }
    
    
    func login() {
        
        //let email = emailTextInput.text
        //let password = passwordTextInput.text
        
        //問題 不管怎樣都登入成功 why?
        
        let email = "321"
        let password = "22fra"
        
        //        Auth.auth().signIn(withEmail: <#T##String#>, link: <#T##String#>, completion: <#T##AuthDataResultCallback?##AuthDataResultCallback?##(AuthDataResult?, Error?) -> Void#>)
        
        //OK
        //Auth.auth().signIn(withEmail: email!, password: password!, completion: <#T##AuthDataResultCallback?##AuthDataResultCallback?##(AuthDataResult?, Error?) -> Void#>)
        
        /*
         
         // Sign in with email and pass.
         // [START authwithemail]
         firebase.auth().signInWithEmailAndPassword(email, password).catch(function(error) {
         // Handle Errors here.
         var errorCode = error.code;
         var errorMessage = error.message;
         // [START_EXCLUDE]
         if (errorCode === 'auth/wrong-password') {
         alert('Wrong password.');
         } else {
         alert(errorMessage);
         }
         console.log(error);
         document.getElementById('quickstart-sign-in').disabled = false;
         // [END_EXCLUDE]
         });
         // [END authwithemail]
         
         */
        
        
        if email != "" && password != "" {
            
            // Login with the Firebase's authUser method
            
            Auth.auth().signIn(withEmail: email, password: password, completion: { error, authData in
                
                if error != nil {
                    print(error)
                    
                    self.loginErrorAlert(title: "Oops!", message: "Check your username and password.")
                    
                    print("請輸入帳號及密碼")
                    
                } else {
                    
                    // Be sure the correct uid is stored.
                    
                    //NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                    
                    // Enter the app!
                    
                    print("登入成功 LOGin")
                    
                    //self.performSegueWithIdentifier("CurrentlyLoggedIn", sender: nil)
                }
            })
            
            
            //            DataService.dataService.BASE_REF.authUser(email, password: password, withCompletionBlock: { error, authData in
            //
            //                if error != nil {
            //                    print(error)
            //                    self.loginErrorAlert("Oops!", message: "Check your username and password.")
            //                } else {
            //
            //                    // Be sure the correct uid is stored.
            //
            //                    NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
            //
            //                    // Enter the app!
            //
            //                    self.performSegueWithIdentifier("CurrentlyLoggedIn", sender: nil)
            //                }
            //            })
            
        } else {
            
            // There was a problem
            
            loginErrorAlert(title: "Oops!", message: "Don't forget to enter your email and password.")
            
            print("帳號或密碼錯誤")
        }
        
        
    }
    
    func loginErrorAlert(title: String, message: String) {
        
        // Called upon login error to let the user know login didn't work.
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    func readData() {
        
        //let userID = Auth.auth().currentUser?.uid
        
        //ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
        
        ref.child("article_database").observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            
            // Get user value
            
            //let value = snapshot.value as? NSDictionary
            
            //let username = value?["username"] as? String ?? ""
            
            //let username = value?["article_title"] as? String ?? ""
            
            print("找到的資料是\(snapshot)")
            
            //let user = User(username: username)
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func readEmailToUid() {
        
        if let friendEmail = friendTextInput.text {
            
            //frank826678@gmail.com
           //ref.child("user_database").child("frank826678_gmail_com").observeSingleEvent(of: .value)
            
            let str = friendEmail
            let replaced = str.replacingOccurrences(of: "@", with: "_")
            let replaced2 = replaced.replacingOccurrences(of: ".", with: "_")
            
            //let newStr = str.replace(target:"@",withString: "_")
            print(replaced2)
            
            ref.child("user_database").child(replaced2).observeSingleEvent(of: .value) { (snapshot) in
                // Get user value
                
                
                
                guard let value = snapshot.value as? NSDictionary else { return self.searchEmailResultLabel.text = "找不到資料" }
                
                guard let userName = value["name"] as? String else { return }
                
                
                guard let userEmail = value["email"] as? String else { return }
                
                
                guard let userUid = value["uid"] as? String else { return }
                
                print(userName)
                print(userEmail)
                print(userUid)
                
                self.searchEmailResultLabel.text = ("名字:\(userName)。Email是:\(userEmail)。UID是:\(userUid)")
                //self.searchEmailResultLabel.text = ("找到UID為\(userUid)")
            
        }
        
            
            
            //self.searchEmailResultLabel.text = ("找的名字\(userName)Email\(userEmail)UID\(userUid)")
            
            //原始
            
            /*
            let value = snapshot.value as? NSDictionary
            
            let userName = value?["name"] as? String
            print(userName!)
            
            let userEmail = value?["email"] as? String
            print(userEmail!)
            
            let userUid = value?["uid"] as? String
            print(userUid!)
            */
            
            //Output
            //Frank2
            //frank826678@gmail.com
            //ybYLaENWESY3KRbPzo95XNG7RCv2
            // OK

        }
        
        
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
    
//    func signUp() {
//
//        let email = "321"
//        let password = "22fra"
//
//        Auth.auth().createUser(withEmail: email, password: password, completion: <#T##AuthDataResultCallback?##AuthDataResultCallback?##(AuthDataResult?, Error?) -> Void#>)
//
////        FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
//
//            if error == nil {
//                print("You have successfully signed up")
//                //Goes to the Setup page which lets the user take a photo for their profile picture and also chose a username
//
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
//                self.present(vc!, animated: true, completion: nil)
//
//            } else {
//                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
//
//                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//                alertController.addAction(defaultAction)
//
//                self.present(alertController, animated: true, completion: nil)
//            }
//        }
    
   // }
    
    func createData() {
        
        // time
        let now:Date = Date()
        
        //let timeInterval:TimeInterval = now.timeIntervalSince1970
        
        //let time:Int = Int(timeInterval)
        
        let dateformatter = DateFormatter()
        
        dateformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        let timeNow = dateformatter.string(from: now)
        
        print("現在日期时间：\(timeNow)")
        
        // 結果 1535982462
        
        //let timeFirebase = now
        
        //        Date().millisecondsSince1970 // 1476889390939
        //        Date(milliseconds: 0) // "Dec 31, 1969, 4:00 PM" (PDT variant of 1970 UTC)
        // timeend
        
        // 要拿 uid 應該要設定登入
        let key = ref.child("posts").childByAutoId().key
        
        
        // "article_database"
        // 在 user_database 下亂數生成一個數字 且下面有一個 ""123": "33fra""
        
        //OK
        //self.ref.child("user_database").child(key).setValue(["123": "33fra"])
        
        //self.ref.child("article_database").child(key).setValue(["123": "33fra"])
        
        //self.ref.child("article_database").child(key).setValue(["article_content" : "testtest","article_id" : key,"article_tag" : "生活","article_title" : "Test 1","create_time" : 1535980912734,"uid" : "6yWtXAWAtFR3hozYw64M11Cd8Bn2"])
        
        self.ref.child("article_database").child(key).setValue(["article_content" : "franktest01","article_id" : key,"article_tag" : "八卦","article_title" : "FrankTest01","create_time" : timeNow,"email" : "frank826678@gmail.com"])
        
        
        
        
        //        "-LLUaB0UZkAIO78TcKFG" : {
        //            "article_content" : "testtest",
        //            "article_id" : "-LLUaB0UZkAIO78TcKFG",
        //            "article_tag" : "生活",
        //            "article_title" : "Test 1",
        //            "create_time" : 1535980912734,
        //            "uid" : "6yWtXAWAtFR3hozYw64M11Cd8Bn2"
        //        }
        //        let post = ["uid": userID,
        //                    "author": username,
        //                    "title": title,
        //                    "body": body]
        
        //        let childUpdates = ["/posts/\(key)": post,
        //                            "/user-posts/\(userID)/\(key)/": post]
        //        //ref.updateChildValues(childUpdates)
        
    }
}



//@IBAction func didTapEmailLogin(_ sender: AnyObject) {
//    if let email = self.emailField.text, let password = self.passwordField.text {
//        showSpinner {
//            // [START headless_email_auth]
//            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
//                // [START_EXCLUDE]
//                self.hideSpinner {
//                    if let error = error {
//                        self.showMessagePrompt(error.localizedDescription)
//                        return
//                    }
//                    self.navigationController!.popViewController(animated: true)
//                }
//                // [END_EXCLUDE]
//            }
//            // [END headless_email_auth]
//        }
//    } else {
//        self.showMessagePrompt("email/password can't be empty")
//    }
//}



