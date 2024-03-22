//
//  MedicalExamsTest.swift
//  MedicalExamsTest
//
//  Created by Maxwell Mastali on 3/21/24.
//

import XCTest
@testable import MedicalExams

class MedicalExamsTest: XCTestCase {


    func givenTestCase() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        let service = MedicalService()
        let inputGivenFile = "/Users/Max/Desktop/IdentifeyeHEALTHTakeHome/MedicalExams/MedicalExams/givenRequests.txt"
        let patients = service.processRequests(inputGivenFile)
        XCTAssertEqual(patients["123"]?.examCount, 0)
        XCTAssertEqual(patients["789"]?.examCount, 2)
    }

}
