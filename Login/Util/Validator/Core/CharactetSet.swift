//
//  CharactetSet.swift
//  Login
//
//  Created by Sujan Vaidya on 7/24/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

protocol CharacterSetValidator: Validator {
  var characterCase: CharacterSet { get }
  var error: Error { get }
}

extension CharacterSetValidator {
  func validate<T>(_ value: T) -> Result<T> {
    let stringValue = value as! String
    return stringValue.rangeOfCharacter(from: characterCase) != nil ?
      .ok(value) :
      .error(error)
  }
  
}

protocol CharacterSetExclusiveValidator: Validator {
  var characterCase: CharacterSet { get }
  var error: Error { get }
}

extension CharacterSetExclusiveValidator {
  func validate<T>(_ value: T) -> Result<T> {
    let stringValue = value as! String
    return stringValue.rangeOfCharacter(from: characterCase) == nil ?
      .ok(value) :
      .error(error)
  }
  
}
