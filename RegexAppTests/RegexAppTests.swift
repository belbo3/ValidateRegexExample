//
//  RegexAppTests.swift
//  RegexAppTests
//
//  Created by Oleksandr Yakobshe on 16.03.2022.
//

import XCTest
@testable import RegexApp

class RegexAppTests: XCTestCase {
  var sut: RegisterData_mock!
  var error: Error!
  
  override func setUp() {
    sut = RegisterData_mock()
  }
  
  override func tearDown() {
    sut = nil
  }
  
  func testEmailEmpty() {
    XCTAssertThrowsError(try sut.validateEmail("")) {
      error = $0
    }
    
    XCTAssertTrue(error is EmailErrors, "Unexpected error type: \(type(of: error))")
    
    XCTAssertEqual(error as? EmailErrors, .emptyError)
  }
  
  func testEmailNotValidated() {
    XCTAssertThrowsError(try sut.validateEmail("yakobshe@i..ua")) {
      error = $0
    }
    
    XCTAssertTrue(error is EmailErrors, "Unexpected error type: \(type(of: error))")
    
    XCTAssertEqual(error as? EmailErrors, .validateError)
  }
  
  func testEmailValidated() {
    try! sut.validateEmail("yakobshe@gmail.com.ua")
    XCTAssertEqual(sut.email, "yakobshe@gmail.com.ua")
  }
  
  func testPasswordForEmpty() {
    XCTAssertThrowsError(try sut.validatePassword("")) {
      error = $0
    }
    
    XCTAssertTrue(error is PasswordErrors, "Unexpected error type: \(type(of: error))")
    
    XCTAssertEqual(error as? PasswordErrors, .emptyError)
  }
  
  func testPasswordForSpecial() {
    XCTAssertThrowsError(try sut.validatePassword("234dg5F", special: true)) {
      error = $0
    }
    
    XCTAssertTrue(error is PasswordErrors, "Unexpected error type: \(type(of: error))")
    
    XCTAssertEqual(error as? PasswordErrors, .specialError)
  }
  
  func testPasswordForNumber() {
    XCTAssertThrowsError(try sut.validatePassword("qwertyasdfgh", number: true)) {
      error = $0
    }
    
    XCTAssertTrue(error is PasswordErrors, "Unexpected error type: \(type(of: error))")
    
    XCTAssertEqual(error as? PasswordErrors, .numberError)
  }
  
  func testPasswordValidate() {
    try! sut.validatePassword("qasW@123", uppercased: true, number: true, special: true, countMin: 8, countMax: 16)
    XCTAssertEqual(sut.password, "qasW@123")
  }
}
