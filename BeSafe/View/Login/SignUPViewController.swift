//
//  SignUPViewController.swift
//  BeSafe
//
//  Created by Yogesh Date on 20/02/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit
import NKVPhonePicker

class SignUPViewController: UIViewController {

    // MARK : - Var
    var mobile_Code   : String?
    var mobile_number : String?
    
    // MARK : - UIController
    @IBOutlet weak var text_Name: UITextField!
    @IBOutlet weak var text_Email: UITextField!
    @IBOutlet weak var text_gender: UITextField!
    @IBOutlet weak var text_Country: UITextField!
    @IBOutlet weak var btn_Country: UIButton!
    @IBOutlet weak var text_State: UITextField!
    @IBOutlet weak var btn_State: UIButton!
    @IBOutlet weak var text_County: UITextField!
    @IBOutlet weak var text_City: UITextField!
    @IBOutlet weak var text_Area: UITextField!
    @IBOutlet weak var text_PinCode: UITextField!
    @IBOutlet weak var text_EmergencyContact1: UITextField!
    @IBOutlet weak var text_ContryCode1: NKVPhonePickerTextField!
    @IBOutlet weak var text_MobileEmergency1: UITextField!
    @IBOutlet weak var text_CountryCode2: NKVPhonePickerTextField!
    @IBOutlet weak var text_EmergencyContact2: UITextField!
    @IBOutlet weak var text_MobileEmergency2: UITextField!
    @IBOutlet weak var security_Code: UITextField!
    @IBOutlet weak var text_Password: UITextField!
    @IBOutlet weak var text_ConfirmPassword: UITextField!
    
    // MARK : - Variable and object
    var objCountry = Country()
    var objState   = State()
    var objDict    = District()
    var objCity    = City()
    
    var selectedDelegate = ""
    var aryCountry = [Country]()
    var aryState   = [State]()
    var aryDistric = [District]()
    var aryCity    = [City]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.text_ContryCode1.phonePickerDelegate = self
        self.text_CountryCode2.phonePickerDelegate = self
        print("Mobile code =\(self.mobile_Code!), Number =\(self.mobile_number!)")

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
        
        if segue.identifier == "segue_Signup_Country" {
            let country = segue.destination as! ListDelegateViewController
            //self.aryCountry.removeAll()
            for i in 0..<aryCountry.count {
                let cnt = self.aryCountry[i]
                country.aryName.append(cnt.countryName!)
            }
            country.listDelegate = self
        }
        
        if segue.identifier == "segue_SignUpState" {
            let state = segue.destination as! ListDelegateViewController
            for i in 0..<aryState.count {
                let obj = self.aryState[i]
                state.aryName.append(obj.state_name!)
            }
            state.listDelegate = self
        }
        
        if segue.identifier == "segue_Signu_County" {
            let county = segue.destination as! ListDelegateViewController
            for i in 0..<self.aryDistric.count {
                let obj = self.aryDistric[i]
                county.aryName.append(obj.districtName!)
            }
            county.listDelegate = self
        }
        
        if segue.identifier == "segue_signUp_City" {
            let county = segue.destination as! ListDelegateViewController
            for i in 0..<self.aryCity.count {
                let obj = self.aryCity[i]
                county.aryName.append(obj.city_name!)
            }
            county.listDelegate = self
        }
        
        if segue.identifier == "segue_SignUp_Gender" {
            let gender = segue.destination as! ListDelegateViewController
            gender.aryName = ["Male ","Female"]
            gender.listDelegate = self
        }
        
    }
 
    
    
    
    
    
    
    // MARK : - UIController Event
    @IBAction func btn_Gender(_ sender: UIButton) {
       self.selectedDelegate = "Gender"
       self.performSegue(withIdentifier: "segue_SignUp_Gender" , sender: self)
    }
    
    @IBAction func btn_Country(_ sender: UIButton) {
        
            self.text_State.text = ""
            self.text_County.text = ""
            self.text_City.text = ""
            self.selectedDelegate = "Country"
            PROGRESS_SHOW(view: self.view)
            self.aryCountry.removeAll()
            Webservices.sharedInstance.beSafeGetCountryList(with: {
                
                aryResponse in
                for i in 0..<aryResponse.count {
                    let obj : Country = aryResponse[i]
                    self.aryCountry.append(obj)
                }
                PROGRESS_HIDE()
                self.performSegue(withIdentifier: "segue_Signup_Country" , sender: self)
            })
            {
                error in
                PROGRESS_ERROR(view: self.view, error: error)
            }
    }
    
    @IBAction func btn_State(_ sender: UIButton) {
        
        self.text_County.text = ""
        self.text_City.text = ""
        self.selectedDelegate = "State"
        self.aryState.removeAll()
        PROGRESS_SHOW(view: self.view)
        Webservices.sharedInstance.beSafeGetStateList(with: self.objCountry.country_id!,
                                                      
        success: {
                aryResponse in
                PROGRESS_HIDE()
                for i in 0..<aryResponse.count {
                    let obj : State = aryResponse[i]
                    self.aryState.append(obj)
                }
                PROGRESS_HIDE()
                self.performSegue(withIdentifier: "segue_SignUpState" , sender: self)
        },
        
        failure: {
            error in
            PROGRESS_ERROR(view: self.view, error: error)
        })
    }
    
    @IBAction func btn_County(_ sender: UIButton) {
        
        self.text_City.text = ""
        self.selectedDelegate = "County"
        self.aryDistric.removeAll()
        PROGRESS_SHOW(view: self.view)
        Webservices.sharedInstance.beSafeGetAllDistric(with: self.objState.state_id!,
                                                       
         success: {
            responseAray in
            PROGRESS_HIDE()
            for i in 0..<responseAray.count {
                let obj : District = responseAray[i]
                self.aryDistric.append(obj)
            }
            PROGRESS_HIDE()
            self.performSegue(withIdentifier: "segue_Signu_County" , sender: self)
                                                        
        },
         
        failure: {
            error in
            PROGRESS_ERROR(view: self.view, error: error)
        })
        
    }
    
    @IBAction func btn_City(_ sender: UIButton) {
        
        self.selectedDelegate = "City"
        self.aryDistric.removeAll()
        PROGRESS_SHOW(view: self.view)
        Webservices.sharedInstance.beSafeAllGetCity(with: self.objDict.district_id!,
        success: {
                responseAray in
                PROGRESS_HIDE()
                for i in 0..<responseAray.count {
                    let obj : City = responseAray[i]
                    self.aryCity.append(obj)
                }
                PROGRESS_HIDE()
                self.performSegue(withIdentifier: "segue_signUp_City" , sender: self)
                
        },
        failure: {
            error in
            PROGRESS_ERROR(view: self.view, error: error)
        })
        
    }
    
    @IBAction func btn_Submit(_ sender: UIButton) {

        if self.validationInSignIn() {
            // implement signup services
            let country1 = self.text_ContryCode1.text!
            let phoneCode1 = country1.replacingOccurrences(of: "+", with: "", options: NSString.CompareOptions.literal, range:nil)
            let country2 = self.text_CountryCode2.text!
            let phoneCode2 = country2.replacingOccurrences(of: "+", with: "", options: NSString.CompareOptions.literal, range:nil)
            
            PROGRESS_SHOW(view: self.view)
             Webservices.sharedInstance.registerNewUser(self.text_Name.text!,
                                                        mobile_country_code: self.mobile_Code!,
                                                        mobile: self.mobile_number!,
                                                        password: self.text_Password.text!,
                                                        email: self.text_Email.text!,
                                                        gender: self.text_gender.text!,
                                                        country_id: self.objCity.id!,
                                                        state_id: self.objState.state_id!,
                                                        city_id: self.objCity.id!,
                                                        district_id: self.objDict.district_id!,
                                                        street: self.text_Area.text!,
                                                        pincode: Int(self.text_PinCode.text!)!,
                                                        security_code: self.security_Code.text!,
                                                        emergencyname1: self.text_EmergencyContact1.text!,
                                                        emergencymobile1: self.text_MobileEmergency1.text!,
                                                        emergencyname: self.text_EmergencyContact2.text!,
                                                        emergencymobile: self.text_MobileEmergency2.text!,
                                                        mb_country_code: phoneCode1,
                                                        mb_country_code1: phoneCode2,
                 success: {
                    
                    success in
                    PROGRESS_HIDE()
                    self.accountCreatedPopUpAleart()
                                                            
             }, failure: {
                
                error in
                PROGRESS_ERROR(view: self.view, error: error)
             })

        }
        
    }
    
    func accountCreatedPopUpAleart() -> Void {
        
        let singOutAction = UIAlertController(title         : nil,
                                              message       : "Registered Successfully.",
                                              preferredStyle: UIAlertControllerStyle.alert)
        
        singOutAction.addAction(UIAlertAction(title : "Ok",
                                              style : UIAlertActionStyle.default,
                                              handler: {
                                                handler in
                                                self.navigationController?.popToRootViewController(animated: true)
                                                
        }))
        self.present(singOutAction, animated: true, completion: nil)
    }
}












//MARK :- FUNction
extension SignUPViewController {
    
    func validationInSignIn() -> Bool {
        
        if self.text_Name.text == "" {
            self.alertView(title: "BeSafe", message: "Enter name")
            return false
        }
        if self.text_Email.text == "" {
            self.alertView(title: "BeSafe", message: "Enter Email")
            return false
        }
        if self.text_Country.text == "" {
            self.alertView(title: "BeSafe", message: "Enter country")
            return false
        }
        if self.text_State.text == "" {
            self.alertView(title: "BeSafe", message: "Enter state")
            return false
        }
        if self.text_County.text == "" {
            self.alertView(title: "BeSafe", message: "Enter county")
            return false
        }
        if self.text_City.text == "" {
            self.alertView(title: "BeSafe", message: "Enter city")
            return false
        }
        if self.text_Area.text == "" {
            self.alertView(title: "BeSafe", message: "Enter area")
            return false
        }
        if self.text_PinCode.text == "" {
            self.alertView(title: "BeSafe", message: "Enter pin")
            return false
        }
        if self.text_EmergencyContact1.text == "" {
            self.alertView(title: "BeSafe", message: "Enter emergency contact 1")
            return false
        }
        if self.text_MobileEmergency1.text == "" {
            self.alertView(title: "BeSafe", message: "enter emergency phon number 1 ")
            return false
        }
        if self.text_EmergencyContact2.text == "" {
            self.alertView(title: "BeSafe", message: "Enter emergency contact 2")
            return false
        }
        if self.text_MobileEmergency2.text == "" {
            self.alertView(title: "BeSafe", message: "enter emergency phon number 2")
            return false
        }
        
        if self.security_Code.text == "" {
            self.alertView(title: "BeSafe", message: "enter security code")
            return false
        }
        if self.text_Password.text == "" {
            self.alertView(title: "BeSafe", message: "enter password")
            return false
        }
        if self.text_ConfirmPassword.text == "" {
            self.alertView(title: "BeSafe", message: "enter confirm password")
            return false
        }
        if !(self.text_Password.text == self.text_ConfirmPassword.text) {
            self.alertView(title: "BeSafe", message: "Re enter confirm password")
            return false
        }
        
        return true
    }
    
    
    func alertView(title : String, message : String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}




extension SignUPViewController : selectedListdelegate {

    
    func didSelectedList(indexpath: Int) {
        
        if  self.selectedDelegate == "Gender" {
            self.selectedDelegate = ""
            if indexpath == 0 {
                self.text_gender.text = "Male"
            }
            if indexpath == 1 {
                self.text_gender.text = "Female"
            }
        }
        
        if self.selectedDelegate == "Country" {
            self.selectedDelegate = ""
            self.objCountry = self.aryCountry[indexpath]
            self.text_Country.text = self.objCountry.countryName!
            print("\n\n IndexPath = \(self.objCountry.countryName!)")
        }
        
        if self.selectedDelegate == "State" {
            self.selectedDelegate = ""
            self.objState = self.aryState[indexpath]
            self.text_State.text = self.objState.state_name!
            print("\n\n IndexPath = \(self.objState.state_name!)")
        }
        
        if self.selectedDelegate == "County" {
            self.selectedDelegate = ""
            self.objDict = self.aryDistric[indexpath]
            self.text_County.text = self.objDict.districtName!
            print("\n\n indexpath = \(self.objDict.districtName!)")
        }
        
        if self.selectedDelegate == "City" {
            self.selectedDelegate = ""
            self.objCity = self.aryCity[indexpath]
            self.text_City.text = self.objCity.city_name
            print("\n\n indexpath = \(self.objCity.id!)")
        }
    }
    
 
}// end

