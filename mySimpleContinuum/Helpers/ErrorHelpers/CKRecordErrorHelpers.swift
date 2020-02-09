//
//  CKRecordErrorHelpers.swift
//  mySimpleContinuum
//
//  Created by Uzo on 2/8/20.
//  Copyright © 2020 Uzo Agu. All rights reserved.
//

import Foundation

enum CKRecordErrorHelper: Error {
    case ckError(Error)
    case unableToUnWrapCKRecordObject
    case unexpectedRecordsFound
    case noUserLoggedIn
    
    
    var errorDescription: String? {
        switch self {
            case .ckError(let error):
                return error.localizedDescription
            case .unableToUnWrapCKRecordObject:
                return "unable to unwrap or get hype object"
            case .unexpectedRecordsFound:
                return "unexpected records found while trying to delete"
            case .noUserLoggedIn:
                return "No user currently logged in"
        }
    }
}
