//
//  LoginVC.swift
//  Login
//
//  Created by Sujan Vaidya on 7/19/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
  
  @IBOutlet weak var emailTitle: UILabel!
  @IBOutlet weak var emailError: UILabel!
  @IBOutlet weak var emailValue: UITextField!
  @IBOutlet weak var passwordTitle: UILabel!
  @IBOutlet weak var passwordError: UILabel!
  @IBOutlet weak var passwordValue: UITextField!
  @IBOutlet weak var nameTitle: UILabel!
  @IBOutlet weak var nameError: UILabel!
  @IBOutlet weak var nameValue: UITextField!
  @IBOutlet weak var quantityTitle: UILabel!
  @IBOutlet weak var quantityError: UILabel!
  @IBOutlet weak var quantityValue: UITextField!
  
  let emailValidator = EmailValidator()
  let passwordValidator = PasswordValidator()
  let nameValidator = NameValidator(regex: "^[a-zA-Z]+(-[a-z]{2,})?('[a-z])?( [a-zA-Z]+(-[a-z]{2,})?('[a-z])?)*$")
  let quantityValidator = QuantityValidator()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    emailValue.keyboardType = .emailAddress
    passwordValue.isSecureTextEntry = true
    emailValue.delegate = self
    emailValue.type = .email
    passwordValue.delegate = self
    passwordValue.type = .password
    nameValue.delegate = self
    nameValue.type = .name
    quantityValue.delegate = self
    quantityValue.type = .quantity
    quantityValue.keyboardType = .numberPad
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  @IBAction func login(_ sender: UIButton) {
    
  }
  
  func validate<T>(value: T, validator: Validator) -> String {
    let validationResult = validator.validate(value);
    guard let errorMsg = validationResult.error?.localizedDescription else { return "" }
    return errorMsg
  
  }

}
