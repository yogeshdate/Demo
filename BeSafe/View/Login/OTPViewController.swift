//
//  OTPViewController.swift
//  BeSafe
//
//  Created by Yogesh Date on 20/02/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit
import NKVPhonePicker


class OTPViewController: UIViewController {
    
    // MARK : - UIController
    @IBOutlet weak var text_ContryCode: NKVPhonePickerTextField!
    @IBOutlet weak var text_Mobile: UITextField!
    @IBOutlet weak var btn_Selected: UIButton!

    // MARK : - Variable
    var isAgreeTerms:Bool = true

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.text_ContryCode.phonePickerDelegate = self
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
        
        if segue.identifier == "segue_GetStarted_Varification" {
            
            let obj = segue.destination as! VerifyMobileViewController
            let codeval = self.text_ContryCode.text!
            let phoneCode = codeval.replacingOccurrences(of: "+", with: "", options: NSString.CompareOptions.literal, range:nil)
            obj.mobile_CountryCode = phoneCode
            obj.mobile_MobileNo = self.text_Mobile.text
        }
    }
    
    
    
    
    
    // MARK : - UIViewController Button
    @IBOutlet weak var btn_Agree: UIButton!
    @IBAction func btn_AcceptTermsCondition(_ sender: UIButton) {
        if self.isAgreeTerms {
            self.btn_Agree.setImage(UIImage(named:"selected"), for: .normal)
        } else {
            self.btn_Agree.setImage(UIImage(named:"unselected"), for: .normal)
        }
        self.isAgreeTerms = !self.isAgreeTerms
    }
    
    @IBAction func btn_GetStarted(_ sender: UIButton) {
        
        if validaton() {
            
                PROGRESS_SHOW(view: self.view)
                Webservices.sharedInstance.checkMobileNumber(self.text_Mobile.text!,
                                                             
                success: {
                         response in
                         PROGRESS_HIDE()
                         self.performSegue(withIdentifier: "segue_GetStarted_Varification", sender: self)
                },
                failure: {
                          error in
                          PROGRESS_ERROR(view: self.view, error: error)
                })
        }
    }
}// end




// MARK : - Function
extension OTPViewController {
    
    func validaton() -> Bool {
        
        if self.text_ContryCode.text == "" {
            self.showAlertController("Select country code")
            return false
        }
        if self.text_Mobile.text == "" {
            self.showAlertController("Enter Mobile No")
            return false
        }
        if self.isAgreeTerms {
            self.showAlertController("Please agree terms and condition")
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
