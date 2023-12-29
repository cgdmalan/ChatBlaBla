//
//  LogInCV.swift
//  ChatProject
//
//  Created by Çiğdem Alan on 7.12.2023.
//

import UIKit
import FirebaseAuth

class LogInCV: UIViewController {
    
    
    @IBOutlet weak var emailTextF: UITextField!
    @IBOutlet weak var passwordTextF: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
     
        
    }
    

   

    
    
    @IBAction func logInBut(_ sender: UIButton) {
        
        if let email = emailTextF.text , let password = passwordTextF.text {
            
            
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                
                if error != nil {
                    
                    let alert = UIAlertController(title: "ERROR", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
                    alert.addAction(okButton)
                    self.present(alert, animated: true)
              }
                else {
                    
                    self.performSegue(withIdentifier: K.logInSegue, sender: self)
                }
                
                
                
            }
            
        }
        
        
        
    }
    
}
