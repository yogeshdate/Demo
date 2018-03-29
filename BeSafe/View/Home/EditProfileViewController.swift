//
//  EditProfileViewController.swift
//  BeSafe
//
//  Created by Yogesh Date on 23/02/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        if segue.identifier == "segue_EditProfile_SecurityInfo" {
            
        }
        if segue.identifier == "segue_EditProfile_PersonalInfo" {
            
        }
    }
    


    // MARK : - UIButton Event 
    @IBAction func btn_PersonalInfo(_ sender: RoundButton) {
        
       //self.performSegue(withIdentifier: "segue_EditProfile_PersonalInfo", sender: self)
        PROGRESS_SHOW(view: self.view)
        Webservices.sharedInstance.updatePersonalInfo(user_id: GlobalDataServices.sharedInstance.user_Me.user_id!,
                                                      success: {
                                                        response in
                                                        PROGRESS_HIDE()
                                                        PROGRESS_SUCCESS_MESSAGE(view: self.view, message: response)
                                                        
        }, failure: {
            error in
            PROGRESS_ERROR(view: self.view, error: error)
        })
    }
    
    @IBAction func btn_SecurityInfo(_ sender: RoundButton) {
        self.performSegue(withIdentifier: "segue_EditProfile_SecurityInfo", sender: self)
    }
    
    @IBAction func btn_UpdateSecurityCode(_ sender: RoundButton) {
        
        PROGRESS_SHOW(view: self.view)
        Webservices.sharedInstance.updateSecurityCode(user_id: GlobalDataServices.sharedInstance.user_Me.user_id!,
                                                      success: {
                                                        response in
                                                        PROGRESS_HIDE()
                                                        PROGRESS_SUCCESS_MESSAGE(view: self.view, message: response)
                                                        
        }, failure: {
            error in
            PROGRESS_ERROR(view: self.view, error: error)
            
        })
        
    }
    
    
}
