//
//  MedicalServiceTests.swift
//  MedicalExamsTest
//
//  Created by Maxwell Mastali on 3/21/24.
//

import XCTest
@testable import MedicalExams

// Running these tests led to a compile error that I was unable to resolve, but these are what my tests would look like :)
class MedicalServiceTests: XCTestCase {

    func givenTestCase() {
        let service = MedicalService()
        let inputGivenFile = "/Users/Max/Desktop/IdentifeyeHEALTHTakeHome/MedicalExams/MedicalExams/givenRequests.txt"
        let patients = service.processRequests(inputGivenFile)
        
        XCTAssertEqual(patients["123"]?.name, "JOHN DOE")
        XCTAssertEqual(patients["123"]?.id, "123")
        XCTAssertEqual(patients["123"]?.examCount, 0)
        
        XCTAssertEqual(patients["789"]?.name, "JANE CROW")
        XCTAssertEqual(patients["789"]?.id, "789")
        XCTAssertEqual(patients["789"]?.examCount, 2)
    }
    
    func newTestCase() {
        let service = MedicalService()
        let inputGivenFile = "/Users/Max/Desktop/IdentifeyeHEALTHTakeHome/MedicalExams/MedicalExams/newRequests.txt"
        let patients = service.processRequests(inputGivenFile)
        
        XCTAssertEqual(patients["123"]?.name, "MAX MASTALI")
        XCTAssertEqual(patients["123"]?.id, "543")
        XCTAssertEqual(patients["123"]?.examCount, 1)
        
        XCTAssertEqual(patients["789"]?.name, "RUSSELL WESTBROOK")
        XCTAssertEqual(patients["789"]?.id, "234")
        XCTAssertEqual(patients["789"]?.examCount, 0)
    }
}
