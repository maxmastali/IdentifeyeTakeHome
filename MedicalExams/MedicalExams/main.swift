//
//  main.swift
//  MedicalExams
//
//  Created by Maxwell Mastali on 3/21/24.
//

import Foundation

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

class MedicalService {
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
                        let patientId = subRequest[2]
                        if patients[patientId] == nil {
                            let name = subRequest[3] + " " + subRequest[4]
                            patients[patientId] = PatientRecord(id: patientId, name: name)
                        }
                    } else if subRequest[1] == "EXAM" {
                        let patientId = subRequest[2]
                        let examId = subRequest[3]
                        if patients[patientId] != nil && exams[examId] == nil {
                            patients[patientId]?.examCount += 1
                            exams[examId] = ExamRecord(patientId: patientId, examId: examId)
                        }
                    }
                }
                else if subRequest[0] == "DEL" {
                    if subRequest[1] == "PATIENT" {
                        let patientId = subRequest[2]
                        if patients[patientId] != nil {
                            patients[patientId] = nil
                            exams = exams.filter { $0.value.patientId == patientId }
                        }
                    }
                    else if subRequest[1] == "EXAM" {
                        let examId = subRequest[2]
                        if let patientId = exams[examId]?.patientId {
                            patients[patientId]?.examCount -= 1
                            exams[examId] = nil
                        }
                    }
                }
            }
        } catch {
            print("Error occurred")
        }
        return patients
    }

    func printPatients(_ patients: [String: PatientRecord]) {
        for patient in patients.values {
            print("Name: \(patient.name), Id: \(patient.id), Exam Count: \(patient.examCount)")
        }
    }

}

var service = MedicalService()

// Will need to change the filepath on your .txt input file
let inputGivenFile = "/Users/Max/Desktop/IdentifeyeHEALTHTakeHome/MedicalExams/MedicalExams/givenRequests.txt"
let givenPatients = service.processRequests(inputGivenFile)
print("Given requests:")
service.printPatients(givenPatients)

let inputNewFile = "/Users/Max/Desktop/IdentifeyeHEALTHTakeHome/MedicalExams/MedicalExams/newRequests.txt"
print("New requests:")
let newPatients = service.processRequests(inputNewFile)
service.printPatients(newPatients)
