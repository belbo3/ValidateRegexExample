//
//  ViewController.swift
//  RegexApp
//
//  Created by Oleksandr Yakobshe on 16.03.2022.
//

import UIKit

final class ViewController: UIViewController {
  // MARK: - Private properties
  
  lazy private var register: RegisterData = {
    return RegisterData()
  }()
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setEmail()
    setPassword()
  }
  
  // MARK: - private methods
  
  private func setEmail() {
    do {
      try register.setUpEmail("qasw2000@mail.com")
    } catch EmailErrors.emptyError {
      // FIXME: - add error handler for empty email row
    } catch EmailErrors.validateError {
      // FIXME: - add error handler for validate error
    } catch {
      // FIXME: - add error handler for unknown error
    }
    
    print(register.email ?? "email nil")
  }
  
  private func setPassword() {
    do {
      try register.setUpPassword("wsdE@1234", uppercased: true, number: true, special: true, countMin: 8, countMax: 16)
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
