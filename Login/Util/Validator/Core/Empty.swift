//
//  Empty.swift
//  Login
//
//  Created by Sujan Vaidya on 7/24/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

protocol EmptyValidator: Validator {
  var error: Error { get }
}

extension EmptyValidator {
  func validate<T>(_ value: T) -> Result<T> {
    guard let stringValue = value as? String else { return .error(nil) }
    return stringValue.isEmpty ? .error(error) : .ok(value)
  }
}
