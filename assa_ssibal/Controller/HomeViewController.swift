//
//  HomeViewController.swift
//  assa_ssibal
//
//  Created by suh on 2017. 11. 5..
//  Copyright © 2017년 suh. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logOutPressed(_ sender: Any) {
        do{
            try Auth.auth().signOut()
        }
        catch{
            print("error")
        }
        
        guard (navigationController?.popToRootViewController(animated: true)) != nil
            else{
                print("no more view controller")
                return
        }
        
    }
    
}
