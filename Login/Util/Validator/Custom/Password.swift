//
//  Password.swift
//  Login
//
//  Created by Sujan Vaidya on 7/24/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

enum PasswordValidationError: Error {
  case empty
  case weak(reasoning: [PasswordStrengthValidationError])
}

extension PasswordValidationError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .empty: return NSLocalizedString("Password field cannot be empty", comment: "Empty password")
    case .weak: return NSLocalizedString("Password format is weak", comment: "Invalid format")
    }
  }
}

enum PasswordStrengthValidationError: Error {
  case length
  case missingUppercase
  case missingLowercase
  case missingNumber
  case missingSpecialCharacter
}

extension PasswordStrengthValidationError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .length: return NSLocalizedString("Password length is invalid", comment: "Invalid length")
    case .missingUppercase: return NSLocalizedString("Password does not contain uppercase", comment: "Invalid format")
    case .missingLowercase: return NSLocalizedString("Password does not contain lowercase", comment: "Invalid format")
    case .missingNumber: return NSLocalizedString("Password does not contain number", comment: "Invalid format")
    case .missingSpecialCharacter: return NSLocalizedString("Password does not contain special character", comment: "Invalid format")
    }
  }
}

class PasswordEmptyValidator: EmptyValidator {
  let error: Error
  
  init(error: Error = PasswordValidationError.empty) {
    self.error = error
  }
  
}

class PasswordLengthValidator: StringLengthValidator {
  var minLength: Int
  var maxLength: Int
  var error: Error
  static let minimumPasswordLength: Int = 8
  static let maximumPasswordLength: Int = 14
  
  init(minLength: Int = minimumPasswordLength, maxLength: Int = maximumPasswordLength, error: Error = PasswordStrengthValidationError.length) {
    self.minLength = minLength
    self.error = error
    self.maxLength = maxLength
  }
}

class PasswordIncludesUppercaseValidator: CharacterSetValidator {
  let characterCase: CharacterSet
  let error: Error
  
  init(characterCase: CharacterSet = NSCharacterSet.uppercaseLetters, error: Error = PasswordStrengthValidationError.missingUppercase) {
    self.characterCase = characterCase
    self.error = error
  }
  
}

class PasswordIncludesLowercaseValidator: CharacterSetValidator {
  let characterCase: CharacterSet
  let error: Error
  
  init(characterCase: CharacterSet = NSCharacterSet.lowercaseLetters, error: Error = PasswordStrengthValidationError.missingLowercase) {
    self.characterCase = characterCase
    self.error = error
  }
  
}

class PasswordIncludesNumbersValidator: CharacterSetValidator {
  let characterCase: CharacterSet
  let error: Error
  
  init(characterCase: CharacterSet = NSCharacterSet.decimalDigits, error: Error = PasswordStrengthValidationError.missingNumber) {
    self.characterCase = characterCase
    self.error = error
  }
  
}

class PasswordIncludesSpecialCharacterValidator: CharacterSetValidator {
  var characterCase: CharacterSet
  var error: Error
  static let characterSet = CharacterSet(charactersIn: "!@#$%^&*()")
  
  init(characterCase: CharacterSet = characterSet, error: Error = PasswordStrengthValidationError.missingSpecialCharacter) {
    self.characterCase = characterCase
    self.error = error
  }
}

class PasswordStrengthValidator: CompositeValidator {
  let validators: [Validator]
  
  init() {
    self.validators = [
      PasswordLengthValidator(),
      PasswordIncludesUppercaseValidator(),
      PasswordIncludesLowercaseValidator(),
      PasswordIncludesNumbersValidator(),
      PasswordIncludesSpecialCharacterValidator()
    ]
  }
  
  func validate<T>(_ value: T) -> Result<T> {
    let result = validate(value) as [Result<T>]
    let errors = result.filter { if case .error(_) = $0 { return true }; return false }
    
    if errors.isEmpty { return .ok(value) }
    
    let reasons: [PasswordStrengthValidationError] = errors.map {
      if case let .error(reason) = $0 { return reason as! PasswordStrengthValidationError }
      fatalError("This code should never be reached. It is an error if it ever hits.")
    }
    
    switch reasons.first! {
    case .length: return .error(PasswordStrengthValidationError.length)
    case .missingLowercase: return .error(PasswordStrengthValidationError.missingLowercase)
    case .missingUppercase: return .error(PasswordStrengthValidationError.missingUppercase)
    case .missingNumber: return .error(PasswordStrengthValidationError.missingNumber)
    case .missingSpecialCharacter: return .error(PasswordStrengthValidationError.missingSpecialCharacter)
    }
    
//    return .error(PasswordValidationError.weak(reasoning: reasons))
  }
}

class PasswordValidator: CompositeValidator {
  let validators: [Validator]
  
  init() {
    self.validators = [
      PasswordEmptyValidator(),
      PasswordStrengthValidator()
    ]
  }
}
