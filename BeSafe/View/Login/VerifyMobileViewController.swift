//
//  VerifyMobileViewController.swift
//  BeSafe
//
//  Created by Yogesh Date on 23/02/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit

class VerifyMobileViewController: UIViewController {

    // MARK : - Variable
    var mobile_CountryCode : String?
    var mobile_MobileNo : String?

    // MARK : - UIController
    @IBOutlet weak var text_OTP: UITextField!
    var randonNumber : String?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.randonNumber = self.generateRandomDigits(4)
         print("\n \n Code = \(mobile_CountryCode!), MOBILE =\(mobile_MobileNo!) OTP =\(self.randonNumber!)")
        
        PROGRESS_SHOW(view: self.view)
        Webservices.sharedInstance.sendSmsBash(self.mobile_MobileNo!,
                                               mobile_country_code: self.mobile_CountryCode!,
                                               text: self.randonNumber!,
        success: {

                response in
                PROGRESS_SUCCESS_MESSAGE(view: self.view, message: response)
                PROGRESS_HIDE()
        },
        
        failure: {

            error in
            PROGRESS_ERROR(view: self.view, error: error)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

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
        if segue.identifier == "segue_VerifyMobile_SignUP" {
            let obj = segue.destination as! SignUPViewController
            obj.mobile_Code = self.mobile_CountryCode
            obj.mobile_number = self.mobile_MobileNo!
        }
    }




    // MARK : - UIBUTTON
    @IBAction func btn_ResendClicked(_ sender: UIButton) {

        PROGRESS_SHOW(view: self.view)
        Webservices.sharedInstance.sendSmsBash(self.mobile_MobileNo!,
                                               mobile_country_code: self.mobile_CountryCode!,
                                               text: self.randonNumber!,
        success: {
            
                response in
                PROGRESS_SUCCESS_MESSAGE(view: self.view, message: response)
                PROGRESS_HIDE()

        }, failure: {
            
            error in
            PROGRESS_ERROR(view: self.view, error: error)
        })
    }

    // OTP varification and display SignUp Screen 
    @IBAction func btn_Submit(_ sender: UIButton) {

        if self.randonNumber == self.text_OTP.text {
            self.performSegue(withIdentifier: "segue_VerifyMobile_SignUP", sender: self)
        }
    }
    
}//end 





// MARK : - Function 
extension VerifyMobileViewController {
   
    func generateRandomDigits(_ digitNumber: Int) -> String {
        var number = ""
        for i in 0..<digitNumber {
            var randomNumber = arc4random_uniform(10)
            while randomNumber == 0 && i == 0 {
                randomNumber = arc4random_uniform(10)
            }
            number += "\(randomNumber)"
        }
        return number
    }
    
    func validaton() -> Bool {
        
        if self.text_OTP.text == "" {
            self.showAlertController(message: "Enter OTP")
            return false
        }
        return true
    }
    
    func showAlertController(message  messag: String) {
        
        let alert = UIAlertController(title: "BeSafe", message: messag, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
            action in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
