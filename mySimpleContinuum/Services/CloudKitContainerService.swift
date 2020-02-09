//
//  CloudKitContainerService.swift
//  mySimpleContinuum
//
//  Created by Uzo on 2/8/20.
//  Copyright © 2020 Uzo Agu. All rights reserved.
//

import Foundation
import CloudKit


struct CloudKitContainerService {
    let publicDB = CKContainer.default().publicCloudDatabase
    
    /**
     Saves a CKRecord to a user's publicDatabase
        - Parameters:
            - T: Generic object type that conforms to  CKSyncable
            - object: Object to save to CloudKit
            - completion: completes with a ResultType
     
        - Returns:
            - success: object saved
            - failure: object not save; error returned/thrown is handled via CKRecordErrorHelper
     */
    func save<T: CKSyncable>(object: T, completion: @escaping (Result<T, CKRecordErrorHelper>) -> Void) {
        
        let record = object.ckRecord
        
        publicDB.save(record) { (ckRecordOptional, errorOptional) in
            if let error = errorOptional{
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(.failure(.ckError(error)))
            }
        }
        
    }
    
    /**
     Fetches an array of CKRecords from the publicDatabase
     
     - Parameters:
        -  T: Generic object type that conforms to CKSyncable
        -   predicate:condition used to determine (via
        comparison of one of more properties of the object ; that is
        fields that instances of that particular record have) what
        records to fetch
        -   completion: complets with a ResultType
     
     - Returns:
        - success: yields an array of saved records that match the
        predicate used
        - failure: no records returned; error thrown handled via
        CKRecordErrorHelper
     */
    
    func fetchRecords<T: CKSyncable>(completion: @escaping (Result<[T], CKRecordErrorHelper>) -> Void) {
        
        /**a predicate is a way to set rules for what
         information we want back. In this case we
         we want all Records so we just pass in true
         */
        let fetchAllPredicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: T.recordType, predicate: fetchAllPredicate)
        
        publicDB.perform(query, inZoneWith: nil) { (recordsArrayOptional, errorOptional) in
            
            if let error = errorOptional {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                
                return completion(.failure(.ckError(error)))
            }
            
            guard let records = recordsArrayOptional
                else {
                    return completion(.failure(.unableToUnWrapCKRecordObject))
            }
            
            let fetchedRecords: [T] = records.compactMap { T(record:$0) }
            
            completion(.success(fetchedRecords))
        }
        
    }
}
