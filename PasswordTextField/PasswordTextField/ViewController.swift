//
//  ViewController.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/25/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func returnHit(_ sender: PasswordField) {
        
        if sender.password.count <= 9 {
            print("You have entered a weak password, your password is: \(sender.password)")
        } else if sender.password.count <= 19 && sender.password.count > 9 {
            print("You have entered a meduim password, your password is: \(sender.password)")
        } else if sender.password.count > 19 {
            print("You have entered a Strong password, your password is: \(sender.password)")
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
