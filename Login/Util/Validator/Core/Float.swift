//
//  Float.swift
//  Login
//
//  Created by Sujan Vaidya on 7/26/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

protocol FloatLimitValidator: Validator {
  var minQuantity: Float { get }
  var maxQuantity: Float { get }
  var error: Error { get }
}

extension FloatLimitValidator {
  func validate<T>(_ value: T) -> Result<T> {
    guard let floatValue = value as? Float else { return .error(nil) }
    return floatValue >= minQuantity && floatValue <= maxQuantity ?
      .ok(value) :
      .error(error)
  }
}

protocol FloatPrecisionValidator: Validator {
  var precisionLength: Int { get }
  var error: Error { get }
}

extension FloatPrecisionValidator {
  func validate<T>(_ value: T) -> Result<T> {
    guard let floatValue = value as? Float else { return .error(nil) }
    return floatValue.precisionCount <= precisionLength ?
      .ok(value) :
      .error(error)
  }
}
