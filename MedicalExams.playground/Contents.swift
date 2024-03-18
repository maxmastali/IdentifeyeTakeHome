import UIKit
import Foundation

class Record {
    let id: String
    let name: String
    let examCount: Int
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
        self.examCount = 0
    }
}

func processRequests(_ requestFile: String) -> [Record] {
    return []
}
