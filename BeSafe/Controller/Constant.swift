//
//  Constant.swift
//  BeSafe
//
//  Created by Yogesh Date on 20/02/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit
import JGProgressHUD

let WEB_API_URL                     = "http://eaccountantapp.com/testwomen/rest/"
let WEB_API_CONTANT                 = "Content-Type"
let WEB_API_TYPE                    = "application/x-www-form-urlencoded"
let WEB_API_RESULT                  = "result"
let WEB_API_SUCCESS                 = "success"
let WEB_API_STATUS                  = "status"
let WEB_API_DATA                    = "data"
let WEB_API_USER_DATA               = "user_data"


let hudProgress = JGProgressHUD(style: .dark)
func PROGRESS_SHOW(view : UIView) {
    hudProgress.textLabel.text = "Please Wait..."
    hudProgress.show(in:view)
}

func PROGRESS_HIDE(){
    hudProgress.dismiss()
}

func PROGRESS_SUCCESS(view : UIView) {
    let hud = JGProgressHUD(style: .dark)
    hud.textLabel.text = "Success..... "
    hud.indicatorView = JGProgressHUDSuccessIndicatorView()
    hud.show(in: view)
    hud.dismiss(afterDelay: 3.0)
}

func PROGRESS_SUCCESS_MESSAGE(view : UIView,message:String) {
    let hud = JGProgressHUD(style: .dark)
    hud.textLabel.text = message
    hud.indicatorView = JGProgressHUDSuccessIndicatorView()
    hud.show(in: view)
    hud.dismiss(afterDelay: 3.0)
}
func PROGRESS_SUCCESS_HOME_MESSAGE(view : UIView,message:String) {
    let hud = JGProgressHUD(style: .dark)
    hud.textLabel.text = message
    hud.indicatorView = JGProgressHUDSuccessIndicatorView()
    hud.show(in: view)
    hud.dismiss(afterDelay: 1.0)
}
func PROGRESS_ERROR(view : UIView, error : String) {
    PROGRESS_HIDE()
    let hud = JGProgressHUD(style: .dark)
    hud.textLabel.text = "\(error)"
    hud.indicatorView = JGProgressHUDErrorIndicatorView()
    hud.show(in: view)
    hud.dismiss(afterDelay: 3.0)
}
