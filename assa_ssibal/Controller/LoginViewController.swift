//
//  LoginViewController.swift
//  assa_ssibal
//
//  Created by suh on 2017. 11. 5..
//  Copyright © 2017년 suh. All rights reserved.
//

import UIKit
import Firebase



class LoginViewController: UIViewController {
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var passwd: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginPressed(_ sender: Any) {
        
        let user = self.user.text! + "@skku.edu"
        
        
        
        
        
        
        
            Auth.auth().signIn(withEmail: user, password: passwd.text!, completion: { (user, error) in
                if Auth.auth().currentUser?.isEmailVerified != true{
                    print("email not verified")
                    
                }
                else{
                    print("login success")
                    
                    
                    self.performSegue(withIdentifier: "goToHome", sender: self)
                }
            })
            
        
        
        
    }
}
