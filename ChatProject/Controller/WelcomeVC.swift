//
//  ViewController.swift
//  ChatProject
//
//  Created by Çiğdem Alan on 7.12.2023.
//

import UIKit

class WelcomeVC: UIViewController {

    @IBOutlet weak var NameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
       
        NameLabel.text = ""
        var Index = 0.0
        let titleText = "ChatBlaBla"
        
       
            
            for letter in titleText {
                Timer.scheduledTimer(withTimeInterval: 0.2 * Index, repeats: false) { timer in
                    
                    self.NameLabel.text?.append(letter)
                }
                Index += 1
           
        }
        
    }

}

