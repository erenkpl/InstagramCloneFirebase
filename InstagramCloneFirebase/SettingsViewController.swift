//
//  SettingsViewController.swift
//  InstagramCloneFirebase
//
//  Created by Eren Küpeli on 29.08.2024.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toViewController", sender: nil)
        }
        catch {
            print("LogOut Error!")
        }
        
    }
    

}
