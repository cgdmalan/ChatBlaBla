//
//  ChatCV.swift
//  ChatProject
//
//  Created by Çiğdem Alan on 7.12.2023.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class ChatCV: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    
    
    @IBOutlet weak var messageTextF: UITextField!
    @IBOutlet weak var tableView: UITableView!
 
    
    let db = Firestore.firestore()
    var messages : [Message] = []
    
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "ChatBlaBla"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", image: nil, target: self, action: #selector(logout))
     
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        
        
        
        loadingMessages()
       
        
        
    }
   
    
    @objc func logout(){
       
            
            do{
                let logout = try Auth.auth().signOut()
                navigationController?.popToRootViewController(animated: true)
            } catch let signOutErr as NSError {
                print("Error signing out: %@", signOutErr)
                
            }
            
            
        
        
    }
   
    
    
    func loadingMessages(){
        
     
        
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener{ (querySnapshot, error) in
        self.messages = []
           if let err = error {
            print("Error getting documents: \(err)")
          } else {
              
            for document in querySnapshot!.documents {
             
                let data = document.data()
                if let messageSender = data [K.FStore.senderField] as? String , let messageBody = data [K.FStore
                    .bodyField] as? String {
                    
                    let newMessage = Message(body: messageBody, sender: messageSender)
                    self.messages.append(newMessage)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                   
                }
            }
          }
        }
        
        
        
        
    }
  
    
    @IBAction func sendMessage(_ sender: UIButton) {
        
        if var messageBody = messageTextF.text , let messageSender = Auth.auth().currentUser?.email{
            
            
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField : messageSender,
                K.FStore.bodyField : messageBody,
                K.FStore.dateField : Date().timeIntervalSince1970
            ]) { error in
                if let err = error {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added . ")
                    
                    DispatchQueue.main.async {
                        self.messageTextF.text = ""
                    }
                    
                    
                }
            }
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messages.count
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! TableViewCell
        cell.messageLabel.text =  message.body
        
        if message.sender == Auth.auth().currentUser?.email{
            
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor.systemMint
            cell.messageLabel.textColor = .darkGray
            
        } else{
            
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = .systemOrange
            cell.messageLabel.textColor = .white
        }
        
        
        
        return cell
        
    }
    
   
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        do{
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            let error = NSError()
             print (error)
        }
        
    }
    

    
}
