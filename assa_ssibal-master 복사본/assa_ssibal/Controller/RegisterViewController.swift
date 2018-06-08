//
//  RegisterViewController.swift
//  assa_ssibal
//
//  Created by suh on 2017. 11. 5..
//  Copyright © 2017년 suh. All rights reserved.
//

import UIKit
import Firebase



class RegisterViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var nicknameSet: UITextField!
    @IBOutlet weak var passwd: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.user.delegate = self
        self.nicknameSet.delegate = self
        self.passwd.delegate = self
        
        handleTextField()
        
        
    }
    
    //텍스트필드 이외 터치시 키보드 숨기기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //리턴버튼 클릭시 키보드 숨기기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        user.resignFirstResponder()
        nicknameSet.resignFirstResponder()
        passwd.resignFirstResponder()
        
        return true
    }
    
    
    
    
    
    
    //빈칸이 있는지 확인
    func handleTextField(){
        user.addTarget(self, action: #selector(RegisterViewController.textFieldDidChanged), for: UIControlEvents.editingChanged)
        passwd.addTarget(self, action: #selector(RegisterViewController.textFieldDidChanged), for: UIControlEvents.editingChanged)
        nicknameSet.addTarget(self, action: #selector(RegisterViewController.textFieldDidChanged), for: UIControlEvents.editingChanged)
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
        
        
        guard let username = user.text, !username.isEmpty, let _ = passwd.text, passwdLengthCheck(),
            let nickname = nicknameSet.text, !nickname.isEmpty else{
                registerButton.isEnabled = false
                registerButton.setTitleColor(UIColor.red, for: UIControlState.normal)
                return
        }
        registerButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        registerButton.isEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func registerPressed(_ sender: Any) {
        
        let kingoID = self.user.text! + "@skku.edu"
        
        
        
        //파이어베이스 사용자 목록에 사용자 생성
        Auth.auth().createUser(withEmail: kingoID, password: passwd.text!, completion: { (user, error) in
            if error != nil{
                print(error!)
            }else{
                
                //사용자 정보 데이터베이스에 저장 "username" : ~~~~
                let ref = Database.database().reference()
                
                let userReference = ref.child("users")
                let uid = user?.uid
                
            
                let newUserReference = userReference.child(uid!)
                newUserReference.setValue(["username": self.user.text!, "nickname": self.nicknameSet.text!])
                
                print("user created")
                
                //이메일 인증 보내기
                Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                    if error != nil{
                        print(error!)
                        
                    }else{
                        print("emial sent")
                        
                        self.performSegue(withIdentifier: "goToLogin", sender: self)
                        
                    }
                })
                
            }
            
        })
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
}
