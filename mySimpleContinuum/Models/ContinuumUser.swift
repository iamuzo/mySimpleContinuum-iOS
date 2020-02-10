//
//  ContinuumUser.swift
//  mySimpleContinuum
//
//  Created by Uzo on 2/8/20.
//  Copyright © 2020 Uzo Agu. All rights reserved.
//

import Foundation
import CloudKit

struct ContinuumUserKeys {
    static let recordTypeKey = "ContinuumUser"
    static let appleUserRefKey = "appleUserRef"
    fileprivate static let usernameKey = "username"
}

class ContinuumUser: CKSyncable {
    var username: String
    var appleUserRef: CKRecord.Reference?

    var recordID: CKRecord.ID
    var ckRecord: CKRecord {
        let ckRecord = CKRecord(
            recordType: ContinuumUser.recordType, recordID: self.recordID
        )

        ckRecord.setValuesForKeys([
            ContinuumUserKeys.usernameKey : self.username
        ])
        
        return ckRecord
    }

    static var recordType: CKRecord.RecordType {
        return ContinuumUserKeys.recordTypeKey
    }

    /**Designated  Initializer*/
    init(username: String,
         appleUserRef: CKRecord.Reference?,
         recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)
    ) {
        self.username = username
        self.appleUserRef = appleUserRef
        self.recordID = recordID
    }

    required convenience init?(ckRecord: CKRecord) {
        guard let username = ckRecord[ContinuumUserKeys.usernameKey] as? String,
            let appleUserRef = ckRecord[ContinuumUserKeys.appleUserRefKey] as? CKRecord.Reference
            else { return nil }
        
        self.init(username: username, appleUserRef: appleUserRef, recordID: ckRecord.recordID )
        
    }

}

extension ContinuumUser: Equatable {
    static func == (lhs: ContinuumUser, rhs: ContinuumUser) -> Bool {
        return lhs.recordID == rhs.recordID
    }
}
