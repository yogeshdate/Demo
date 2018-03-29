//
//  SecurityInfoViewController.swift
//  BeSafe
//
//  Created by Yogesh Date on 23/02/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit

class SecurityInfoViewController: UIViewController {

    // MARK : - UIController 
    @IBOutlet weak var text_SecurityCode: UITextField!
    @IBOutlet weak var text_password: UITextField!
    @IBOutlet weak var text_ConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func Btn_Submit(_ sender: UIButton) {
        
        if self.validationChangePassword() {
            
            self.text_SecurityCode.resignFirstResponder()
            self.text_password.resignFirstResponder()
            self.text_ConfirmPassword.resignFirstResponder()
            
            PROGRESS_SHOW(view: self.view)
            Webservices.sharedInstance.changeUserPassword(GlobalDataServices.sharedInstance.user_Me.user_id!,
                                                          password: self.text_password.text!,
            success: {
                message in
                PROGRESS_SUCCESS_MESSAGE(view: self.view, message: message)
                PROGRESS_HIDE()
                self.text_SecurityCode.text = ""
                self.text_password.text = ""
                self.text_ConfirmPassword.text = ""
            },
            failure: {
                error in
                PROGRESS_ERROR(view: self.view, error: error)
            })
        }
    }
}



// MARK : - Function
extension SecurityInfoViewController {
    
    func validationChangePassword() -> Bool {
        
        if self.text_SecurityCode.text == "" {
            self.showAlertController("Enter Security code")
            return false
        }
        if self.text_password.text == "" {
            self.showAlertController("Enter password")
            return false
        }
        if self.text_ConfirmPassword.text == "" {
            self.showAlertController("Enter confirm password")
            return false
        }
        if !(GlobalDataServices.sharedInstance.user_Me.security_code == self.text_SecurityCode.text) {
            self.showAlertController("Please enter valid security code")
            return false
        }
        if !(self.text_password.text == self.text_ConfirmPassword.text) {
            self.showAlertController("Password does not matches")
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





