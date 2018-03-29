//
//  ForgotPasswordViewController.swift
//  BeSafe
//
//  Created by Yogesh Date on 28/02/18.
//  Copyright © 2018 Yogesh date. All rights reserved. hay.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    // MARK :- UIController
    @IBOutlet weak var text_emaill: UITextField!
    
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







    // MARK  : - UIButton
    @IBAction func btn_Cancel(_ sender: UIBarButtonItem) {
        self.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btn_Submit(_ sender: UIButton) {
        if self.validationSubmit() {
            PROGRESS_SHOW(view: self.view)
            Webservices.sharedInstance.forgotUserPassword(self.text_emaill.text!,
            success: {
                response in
                PROGRESS_SUCCESS_MESSAGE(view: self.view, message: response )
                PROGRESS_HIDE()
                self.text_emaill.text = ""

            },
            failure: {
                error in
                PROGRESS_ERROR(view: self.view, error: error)
            })
        }
    }
    




    // MARK : - Function
    func validationSubmit() -> Bool {
        
        if self.text_emaill.text == "" {
            self.showAlertController(message: "Enter emai;")
            return false
        }
        return true
    }
    
    func showAlertController(message messag: String) {
        
        let alert = UIAlertController(title: "BeSafe", message: messag, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
            action in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
