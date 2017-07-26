//
//  Core.swift
//  Login
//
//  Created by Sujan Vaidya on 7/24/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

enum Result<T> {
  case ok(T)
  case error(Error)
  
  var value: T? {
    switch self {
    case .ok(let value):
      return value
    case .error:
      return nil
    }
  }
  
  var error: Error? {
    switch self {
    case .ok:
      return nil
    case .error(let error):
      return error
    }
  }
}

protocol Validator {
  func validate<T>(_ value: T) -> Result<T>
}

protocol CompositeValidator: Validator {
  var validators: [Validator] { get }
  
  func validate<T>(_ value: T) -> [Result<T>]
}

extension CompositeValidator {
  func validate<T>(_ value: T) -> [Result<T>] {
    return validators.map { $0.validate(value) }
  }
  
  func validate<T>(_ value: T) -> Result<T> {
    let results: [Result<T>] = validate(value)
    let errors = results.filter {
      if case .error(_) = $0 {
        return true
      }
      else {
        return false
      }
    }
    
    return errors.first ?? .ok(value)
  }
  
}
