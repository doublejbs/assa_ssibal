//
//  ProfileViewController.swift
//  assa_ssibal
//
//  Created by suh on 2017. 11. 8..
//  Copyright © 2017년 suh. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

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
    
    //로그아웃 버튼
    @IBAction func logoutPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            
            
            
        }
        catch let logoutError{
            print(logoutError)
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateInitialViewController()
        
        self.present(loginVC!, animated: true, completion: nil)
    }
    
}
