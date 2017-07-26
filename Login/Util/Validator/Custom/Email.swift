//
//  Email.swift
//  Login
//
//  Created by Sujan Vaidya on 7/24/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

enum EmailValidationError: Error {
  case empty
  case invalidFormat
}

extension EmailValidationError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .empty: return NSLocalizedString("Email field cannot be empty", comment: "Empty email")
    case .invalidFormat: return NSLocalizedString("Email format is not valid", comment: "Invalid format")
    }
  }
}

class EmailEmptyValidator: EmptyValidator {
  let error: Error
  
  init(error: Error = EmailValidationError.empty) {
    self.error = error
  }
  
}

class EmailFormatValidator: RegexValidator {
  let REGEX: String
  let error: Error
  
  static let regex = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
  
  init(regex: String = regex, error: Error = EmailValidationError.invalidFormat) {
    self.REGEX = regex
    self.error = error
  }
  
}

class EmailValidator: CompositeValidator {
  let validators: [Validator]
  
  init() {
    self.validators = [
      EmailEmptyValidator(),
      EmailFormatValidator()
    ]
  }
}
