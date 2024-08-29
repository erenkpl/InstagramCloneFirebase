//
//  ViewController.swift
//  InstagramCloneFirebase
//
//  Created by Eren Küpeli on 29.08.2024.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func signinButton(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
            
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { authData, error in
                
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Unknown Error") // ?? işareti error.localized boş dönerse default value döndürülecek.
                }
                else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        }
        else {
            self.makeAlert(titleInput: "Error", messageInput: "Username/Password can't be blank.")
        }
        
    }
    
    @IBAction func signupButton(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
            // Tek satırda, textfield'a girilen bilgiler ile kullanıcıyı firebase sunucusuna kayıt ettik.
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { authData, error in
                
                if error != nil {
                    // Auth, error mesajını kendisi tanımlıyor.
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Unknown Error") // sondaki ?? işareti default value.
                }
                else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
                
            }
        }
        else {
            makeAlert(titleInput: "Error", messageInput: "Username/Password can't be blank.")
        }
    }
    
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}

