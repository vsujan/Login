//
//  LoginVCExtension.swift
//  Login
//
//  Created by Sujan Vaidya on 7/19/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

extension LoginVC: UITextFieldDelegate {
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    switch textField.type {
    case .email:
      if let emailText = textField.text {
        emailError.text = self.validate(value: emailText, validator: emailValidator)
      }
      
    case .password :
      if let passwordText = textField.text {
        passwordError.text = self.validate(value: passwordText, validator: passwordValidator)
      }
      
    case .name:
      if let nameText = textField.text {
        nameError.text = self.validate(value: nameText, validator: nameValidator)
      }
      
    case .quantity:
      if let quantityText = textField.text {
        if let doubleValue = quantityText.doubleValue {
          quantityError.text = self.validate(value: doubleValue, validator: quantityValidator)
        }
      }
      
    default:
      return
    }
  }
  
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      switch textField.type {
      case .quantity:
        let inverseSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let components = string.components(separatedBy: inverseSet)
        let filtered = components.joined(separator: "")
        if filtered == string {
          return true
        } else {
          if string == "." {
            let countdots = textField.text!.components(separatedBy:".").count - 1
            if countdots == 0 {
              return true
            }else{
              if countdots > 0 && string == "." {
                return false
              } else {
                return true
              }
            }
          }else{
            return false
          }
        }
        
      default :
        return true
      }
    }
}
