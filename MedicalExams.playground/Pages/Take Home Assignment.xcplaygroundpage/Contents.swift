import UIKit
import Foundation
import XCTest

class PatientRecord {
    let id: String
    let name: String
    var examCount: Int
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
        self.examCount = 0
    }
}

class ExamRecord {
    let patientId: String
    let examId: String
    
    init(patientId: String, examId: String) {
        self.patientId = patientId
        self.examId = examId
    }
}

func processRequests(_ requestFile: String) -> [String:PatientRecord] {
    var patients = [String:PatientRecord]()
    var exams = [String: ExamRecord]()
    
    do {
        let input = try String(contentsOfFile: requestFile, encoding: .utf8)
        let requests = input.components(separatedBy: .newlines)
        
        for request in requests {
            let subRequest = request.components(separatedBy: .whitespaces)
            if subRequest[0] == "ADD" {
                if subRequest[1] == "PATIENT" {
                    var patientId = subRequest[2]
                    if patients[patientId] == nil {
                        var name = subRequest[3] + " " + subRequest[4]
                        patients[patientId] = PatientRecord(id: patientId, name: name)
                    }
                } else if subRequest[1] == "EXAM" {
                    var patientId = subRequest[2]
                    var examId = subRequest[3]
                    if patients[patientId] != nil && exams[examId] == nil {
                        patients[patientId]?.examCount != 1
                        exams[examId] = ExamRecord(patientId: patientId, examId: examId)
                    }
                }
            }
            else if subRequest[0] == "DEL" {
                if subRequest[1] == "PATIENT" {
                    var patientId = subRequest[2]
                    if patients[patientId] != nil {
                        patients[patientId] = nil
                        exams.filter { $0.value.patientId == patientId }
                    }
                }
                else if subRequest[1] == "EXAM" {
                    var examId = subRequest[2]
                    if var patientId = exams[examId]?.patientId {
                        patients[patientId]?.examCount -= 1
                        exams[examId] = nil
                    }
                }
            }
        }
    } catch {
        print("Error occurred \(error)")
    }
    return patients
}

func printSummary(_ patients: [String: PatientRecord]) {
    for patient in patients.values {
        print("Name: \(patient.name), Id: \(patient.id), Exam Count: \(patient.examCount)")
    }
}

let inputFile = "/Sources/requests.txt"
let patients = processRequests(inputFile)
printSummary(patients)

