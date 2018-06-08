//
//  LoginViewController.swift
//  assa_ssibal
//
//  Created by suh on 2017. 11. 5..
//  Copyright © 2017년 suh. All rights reserved.
//

import UIKit
import Firebase



class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var passwd: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.user.delegate = self
        self.passwd.delegate = self
        
        
        handleTextField()
        //자동로그인
        if Auth.auth().currentUser != nil && Auth.auth().currentUser?.isEmailVerified == true{
            self.performSegue(withIdentifier: "goToTimetable", sender: nil)
        }
    }
    //빈칸이 있는지 확인
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //텍스트필드 이외 터치시 키보드 숨기기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //리턴버튼 클릭시 키보드 숨기기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        user.resignFirstResponder()
        
        passwd.resignFirstResponder()
        
        return true
    }
    
    
    
    func handleTextField(){
        user.addTarget(self, action: #selector(RegisterViewController.textFieldDidChanged), for: UIControlEvents.editingChanged)
        passwd.addTarget(self, action: #selector(RegisterViewController.textFieldDidChanged), for: UIControlEvents.editingChanged)
       
    }
    //비밀번호 6자리 이상 체크
    func passwdLengthCheck() -> Bool{
        if (passwd.text?.count)! < 6 {
            return false
        }else{
            return true
        }
    }
    //버튼 활성화
    @objc func textFieldDidChanged(){
        
        loginButton.isEnabled = false
        guard let username = user.text, !username.isEmpty, let _ = passwd.text, passwdLengthCheck()
             else{
                loginButton.isEnabled = false
                loginButton.setTitleColor(UIColor.red, for: UIControlState.normal)
                return
        }
        loginButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        loginButton.isEnabled = true
    }
    
    
    @IBAction func loginPressed(_ sender: Any) {
        
        
        
        let user = self.user.text! + "@skku.edu"
        
        
        
        
            Auth.auth().signIn(withEmail: user, password: passwd.text!, completion: { (user, error) in
                if Auth.auth().currentUser?.isEmailVerified != true{
                    print("email not verified")
                    
                }
                else{
                    print("login success")
                    
                    
                    self.performSegue(withIdentifier: "goToTimetable", sender: self)
                }
            })
            
        
        
        
    }
}
