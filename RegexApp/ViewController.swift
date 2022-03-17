//
//  ViewController.swift
//  RegexApp
//
//  Created by Oleksandr Yakobshe on 16.03.2022.
//

import UIKit

final class ViewController: UIViewController {
  // MARK: - Private properties
  
  lazy private var register: ValidateData = {
    return ValidateData()
  }()
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    validateEmail("qasw2000@mail.com")
    validatePassword("wsdE@1234")
  }
  
  // MARK: - private methods
  
  private func validateEmail(_ email: String) {
    do {
      try register.validateEmail(email)
    } catch EmailErrors.emptyError {
      // FIXME: - add error handler for empty email row
    } catch EmailErrors.validateError {
      // FIXME: - add error handler for validate error
    } catch {
      // FIXME: - add error handler for unknown error
    }
    
    print(register.email ?? "email nil")
  }
  
  private func validatePassword(_ password: String) {
    do {
      try register.validatePassword(password, uppercased: true, number: true, special: true, countMin: 8, countMax: 16)
    } catch PasswordErrors.emptyError {
      // FIXME: - add error handler for empty password row
    } catch PasswordErrors.numberError {
      // FIXME: - add error handler for the absence тгьиук character in password
    } catch PasswordErrors.specialError {
      // FIXME: - add error handler for the absence special character in password
    } catch PasswordErrors.uppercasedError {
      // FIXME: - add error handler for the absence uppercased character in password
    } catch PasswordErrors.maxError {
      // FIXME: - add error handler for password count higher then max
    } catch PasswordErrors.minError {
      // FIXME: - add error handler for password count less then min
    } catch {
      // FIXME: - add error handler for unknown error
    }
    
    print(register.password ?? "password nil")
  }
}
