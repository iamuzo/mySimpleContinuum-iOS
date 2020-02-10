//
//  SignUpViewController.swift
//  mySimpleContinuum
//
//  Created by Uzo on 2/9/20.
//  Copyright © 2020 Uzo Agu. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    // MARK: - OUTLETS
    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - ACTIONS
    @IBAction func signupButtonTapped(_ sender: UIButton) {
        
        guard let username = usernameTextField.text, !username.isEmpty else { return }
        
        ContinuumUserController.sharedInstance.createUserWith(username) { (result) in
            switch result {
                case .success(let user):
                    print(user?.username ?? "none")
                    ContinuumUserController.sharedInstance.currentUser = user
                
                case .failure(let error):
                    print(error)
            }
        }
        
        usernameTextField.text = ""
        usernameTextField.resignFirstResponder()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

    // MARK: - Custom Methods
    func fetchUser() {
    }

}
