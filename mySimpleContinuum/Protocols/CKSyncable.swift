//
//  CKSyncable.swift
//  mySimpleContinuum
//
//  Created by Uzo on 2/8/20.
//  Copyright © 2020 Uzo Agu. All rights reserved.
//

import UIKit
import CloudKit

/**
 A protocol defines a blueprint of methods, propeties,
 and other requirements that suit a particular task or
 piece of functionality.
 
 The protocol can then be adopted by a class, struct, or
 enum to provide an actual implentation of those methods,
 properties, or requirements.
 
 Any type that satisfies these methods, properties or
 requirements is said to conform to that specific protocol
 */
//protocol CKSyncable {
//    /**ability to get (retrieve ) and set(alter/change) a CKRecord ID*/
//    var recordID: CKRecord.ID { get set }
//    /**ability to get/retrieve a ckRecord */
//    var ckRecord: CKRecord { get }
//    static var recordType: CKRecord.RecordType { get }
//    init?(record: CKRecord)
//}

protocol CKSyncable: class {
    /**ability to get (retrieve ) and set(alter/change) a CKRecord ID*/
    var recordID: CKRecord.ID { get set }
    /**ability to get/retrieve a ckRecord */
    var ckRecord: CKRecord { get }
    static var recordType: CKRecord.RecordType { get }
    init?(ckRecord: CKRecord)
}
