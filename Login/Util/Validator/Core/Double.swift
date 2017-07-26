//
//  Double.swift
//  Login
//
//  Created by Sujan Vaidya on 7/25/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

protocol DoubleLimitValidator: Validator {
  var minQuantity: Double { get }
  var maxQuantity: Double { get }
  var error: Error { get }
}

extension DoubleLimitValidator {
  func validate<T>(_ value: T) -> Result<T> {
    let doubleValue = value as! Double
    return doubleValue >= minQuantity && doubleValue <= maxQuantity ?
      .ok(value) :
      .error(error)
  }
}

protocol DoublePrecisionValidator: Validator {
  var precisionLength: Int { get }
  var error: Error { get }
}

extension DoublePrecisionValidator {
  func validate<T>(_ value: T) -> Result<T> {
    let doubleValue = value as! Double
    return doubleValue.precisionCount <= precisionLength ?
      .ok(value) :
      .error(error)
  }
}
