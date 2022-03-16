//
//  Models.swift
//  RegexApp
//
//  Created by Oleksandr Yakobshe on 16.03.2022.
//

import Foundation

// MARK: - Error enums

enum EmailErrors: Error {
  case emptyError
  case validateError
}

extension EmailErrors: CustomStringConvertible {
  public var description: String {
    switch self {
    case .emptyError: return "email is empty"
    case .validateError: return "email is not validated"
    }
  }
}

enum PasswordErrors: Error {
  case uppercasedError
  case numberError
  case specialError
  case emptyError
  case minError
  case maxError
}

extension PasswordErrors: CustomStringConvertible {
  public var description: String {
    switch self {
    case .uppercasedError: return "password dont contains uppercased"
    case .numberError: return "password is not validated"
    case .specialError: return "password is not validated"
    case .emptyError: return "password is not validated"
    case .minError: return "password is lower then Min count characters"
    case .maxError: return "password is higher then Max count characters"
    }
  }
}

// MARK: - Class

class RegisterData {
  private(set) var email: String!
  private(set) var password: String!
  
  func setUpEmail(_ email: String) throws {
    let emailRegex = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
    if emailPredicate.evaluate(with: email) {
      self.email = email
    } else {
      if email.isEmpty {
        throw EmailErrors.emptyError
      }
      throw EmailErrors.validateError
    }
  }
  
  func setUpPassword(_ password: String, uppercased: Bool = false, number: Bool = false, special: Bool = false, countMin: Int = 1, countMax: Int = 100) throws {
    let uppercasedRegex = uppercased ? "(?=.*[A-Za-z])" : ""
    let numberRegex = number ? "(?=.*[0-9])" : ""
    let specialRegex = special ? "(?=.*[$@$!%*#?&])" : ""
    let passwordRegex = "\(uppercasedRegex)\(numberRegex)\(specialRegex)([A-Za-z0-9$@$!%*#?&]){\(countMin),\(countMax)}"
    let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
    if passwordPredicate.evaluate(with: password) {
      self.password = password
    } else {
      if password.isEmpty {
        throw PasswordErrors.emptyError
      }
      if uppercased {
        let predicate = NSPredicate(format:"SELF MATCHES %@", "(.*[A-Z]+.*)")
        if !predicate.evaluate(with: password) {
          throw PasswordErrors.uppercasedError
        }
      }
      if number {
        let predicate = NSPredicate(format:"SELF MATCHES %@", "(.*[0-9]+.*)")
        if !predicate.evaluate(with: password) {
          throw PasswordErrors.numberError
        }
      }
      if special {
        let predicate = NSPredicate(format:"SELF MATCHES %@", "(.*[$@$!%*#?&]+.*)")
        if !predicate.evaluate(with: password) {
          throw PasswordErrors.specialError
        }
      }
      if password.count < countMin {
        throw PasswordErrors.minError
      }
      if password.count > countMax {
        throw PasswordErrors.maxError
      }
    }
  }
}

// MARK: - Mock class

class RegisterData_mock: RegisterData {
  override func setUpEmail(_ email: String) throws {
    try super.setUpEmail(email)
  }
  
  override func setUpPassword(_ password: String, uppercased: Bool = false, number: Bool = false, special: Bool = false, countMin: Int = 1, countMax: Int = 100) throws {
    try super.setUpPassword(password, uppercased: uppercased, number: number, special: special, countMin: countMin, countMax: countMax)
  }
}
