//
//  LoginViewController.swift
//  BeSafe
//
//  Created by Yogesh Date on 20/02/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit
import NKVPhonePicker

class LoginViewController: UIViewController {

    // MARK : - UIController
    @IBOutlet weak var text_Code: NKVPhonePickerTextField!
    @IBOutlet weak var text_UName: UITextField!
    @IBOutlet weak var text_Password: UITextField!
    

    override func viewDidLoad() {

        super.viewDidLoad()
        self.text_Code.phonePickerDelegate = self

        // check user login or not
        print("\n\n\n\n Name =\(String(describing: UserDefaults.standard.string(forKey:"name")))");
        let obj = GlobalDataServices.sharedInstance.checkUserObj()
        if !(obj.name == nil) {
            self.performSegue(withIdentifier: "segue_Login_Home",sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segue_Home_getStarted" {
            
        }
        if segue.identifier == "segue_Login_Home" {
            
        }
    }
    
    
    
    
    // MARK  : - UIController event
    @IBAction func btn_SignIn(_ sender: UIButton) {
        
        if self.validatonSignIn() {
            //implement login webservice
            let codeval = self.text_Code.text!
            let phoneCode = codeval.replacingOccurrences(of: "+", with: "", options: NSString.CompareOptions.literal, range:nil)
            
            PROGRESS_SHOW(view: self.view)
            Webservices.sharedInstance.loginWithUser(withuserName: self.text_UName.text!,
                                                     password: self.text_Password.text!,
                                                     countryCode : phoneCode,
            success: {

                    response in
                    GlobalDataServices.sharedInstance.insertNewUser(user: response)
                    self.text_UName.text = ""
                    self.text_Password.text = ""
                    PROGRESS_HIDE()
                    self.performSegue(withIdentifier: "segue_Login_Home", sender: self)
            },
            
            failure: {
                    error in
                    PROGRESS_ERROR(view: self.view, error: error)
            })
        }
    }
    
    @IBAction func btn_SignUp(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segue_Home_getStarted", sender: self)
    }
    
    @IBAction func btn_ForgotPassword(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segue_login_forgotPassword", sender: self)
    }
    
}






// MARK : - Function
extension LoginViewController {
    
    func validatonSignIn() -> Bool {
        
        if self.text_UName.text == "" {
            self.showAlertController("Enter user name")
            return false
        }
        if self.text_Password.text == "" {
            self.showAlertController("Enter password")
            return false
        }
        return true
    }
    
    func showAlertController(_ messag: String) {
        
        let alert = UIAlertController(title: "BeSafe", message: messag, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
            action in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
