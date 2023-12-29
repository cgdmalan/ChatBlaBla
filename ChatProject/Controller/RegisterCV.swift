//
//  RegisterCV.swift
//  ChatProject
//
//  Created by Çiğdem Alan on 7.12.2023.
//

import UIKit
import FirebaseAuth

class RegisterCV: UIViewController {
    
    
    @IBOutlet weak var emailTextF: UITextField!
    @IBOutlet weak var passwordTextF: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    
        
    }
    
  
        
   
    

    @IBAction func registerBut(_ sender: Any) {
        
        
      if  let email = emailTextF.text , let password = passwordTextF.text  {
          
          Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
           
              if error != nil {
                  
                  let alert = UIAlertController(title: "ERROR", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                  let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
                  alert.addAction(okButton)
                  self.present(alert, animated: true)
            }
              else {
                  
                  self.performSegue(withIdentifier: K.registerSegue, sender: self)
              }
              
          }
            
        }
        
        
    }
    
}
