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

class ViewController: UIViewController {

    @IBOutlet weak var emailTextInput: UITextField!
    
    @IBOutlet weak var passwordTextInput: UITextField!
    
    var ref: DatabaseReference!
    
    //ref = Database.database().reference()
    //Expected declaration

    
    @IBAction func logInBtnClick(_ sender: UIButton) {
    
        
    //let ref = Database.database().reference()
    
        //login()
        //createData()
        
        //readData()
        
        readSpecifiedData()
        
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
        
        let email = emailTextInput.text
        let password = passwordTextInput.text
        
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
            
            Auth.auth().signIn(withEmail: email!, password: password!, completion: { error, authData in
                
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
        
        let postsByMostPopular = ref.child("article_database").queryOrdered(byChild: "article_tag").queryEqual(toValue: keyWord)
        
        postsByMostPopular.observeSingleEvent(of: .value, with: { (snapshot)
            
            in
            
            print("找到的資料是\(snapshot)")
            let a = snapshot.value as! NSDictionary
            print("奇怪東西\(a)")
            
                    })
        
        
    }
    
    func createData() {
        
        let key = ref.child("posts").childByAutoId().key
        
        
        // 在 user_database 下亂數生成一個數字 且下面有一個 ""123": "33fra""
        self.ref.child("user_database").child(key).setValue(["123": "33fra"])
        
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



