//
//  Float.swift
//  Login
//
//  Created by Sujan Vaidya on 7/26/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

protocol FloatValidator: Validator {
  var minQuantity: Float { get }
  var maxQuantity: Float { get }
  var precisionLength: Int { get }
  var error: Error { get }
}

extension FloatValidator {
  func validate<T>(_ value: T) -> Result<T> {
    let floatValue = value as! Float
    return floatValue >= minQuantity && floatValue <= maxQuantity && floatValue.precisionCount <= precisionLength ?
      .ok(value) :
      .error(error)
  }
}
