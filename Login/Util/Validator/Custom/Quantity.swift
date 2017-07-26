//
//  Quantity.swift
//  Login
//
//  Created by Sujan Vaidya on 7/26/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

enum QuantityValidationError: Error {
  case limit
  case precision
}

extension QuantityValidationError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .limit: return NSLocalizedString("The quantity is not allowed", comment: "Invalid quantity")
    case .precision: return NSLocalizedString("The precision is not allowed", comment: "Invalid precision")
    }
  }
}

class QuantityLimitValidator: DoubleLimitValidator {
  var minQuantity: Double
  var maxQuantity: Double
  var error: Error
  
  init(min: Double = 0.0, max: Double = 10.0, error: Error = QuantityValidationError.limit) {
    self.minQuantity = min
    self.maxQuantity = max
    self.error = error
  }
}

class QuantityPrecisionValidator: DoublePrecisionValidator {
  var precisionLength: Int
  var error: Error
  
  init(precisionLength: Int = 2, error: Error = QuantityValidationError.precision) {
    self.precisionLength = precisionLength
    self.error = error
  }
}

class QuantityValidator: CompositeValidator {
  var validators: [Validator]
  
  init() {
    self.validators = [QuantityLimitValidator(), QuantityPrecisionValidator()]
  }
}
