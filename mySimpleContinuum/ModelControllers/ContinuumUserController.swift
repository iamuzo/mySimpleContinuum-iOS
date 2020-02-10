//
//  ContinuumUserController.swift
//  mySimpleContinuum
//
//  Created by Uzo on 2/9/20.
//  Copyright © 2020 Uzo Agu. All rights reserved.
//

import Foundation
import CloudKit

class ContinuumUserController {
    
    var currentUser: ContinuumUser?
    let container = CloudKitContainerService()
    static let sharedInstance = ContinuumUserController()

    private func fetchAppleUserReference(completion: @escaping (_ reference: CKRecord.Reference?) -> Void) {
        
        CKContainer.default().fetchUserRecordID { (ckRecordID, error) in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) \n---\n \(error)")
                completion(nil)
            }
            
            if let ckRecordID = ckRecordID {
                let reference = CKRecord.Reference(recordID: ckRecordID, action: .deleteSelf)
                completion(reference)
            }
        }
    }
    
    func createUserWith(_ username: String, completion: @escaping (Result<ContinuumUser?, CKRecordErrorHelper>) -> Void) {
        
        fetchAppleUserReference { (appleUserReference) in
            
            guard let userRef = appleUserReference else {
                return completion(.failure(.appleUserNotLoggedIn))
            }
            
            let user = ContinuumUser(username: username, appleUserRef: userRef)
            
            /**
             I get this error:
             `Contextual closure type '(Result<_, CKRecordErrorHelper>) -> Void' expects 1 argument,`
             `but 2 were used in closure body` when I use 2 args in the result (that is I am expecting something
             like (synableObject, error)).
             Why?
             Error disappears when I pass in only one arg `result`
             */
            self.container.save(object: user) { (result) in
                switch result {
                    /**Is user a optional? or not?*/
                    case .success(let user):
                        print(user.username)
                        completion(.success(user))
                    case .failure(let error):
                        print(error.localizedDescription)
                        completion(.failure(.ckError(error)))
                }
            }
        }
    }
}
