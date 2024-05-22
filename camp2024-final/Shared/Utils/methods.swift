//
//  methods.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 21/05/24.
//

import SwiftUI

func convertCodeToUserId(code: String) -> Int {
    switch code.uppercased() {
    case "B5P7TR": return 20 //usei pra teste01
    case "H2L9YC": return 21 //usei para teste02
    case "F8T6QD": return 22
    case "K4N3ZM": return 23
    case "W1B9JV": return 24
    case "R2M7GH": return 25
    case "X5L3PN": return 26
    case "J7Q2WF": return 27
    case "D8V5LT": return 28
    case "P4K6YB": return 29
    case "N1Z8CR": return 30
    case "G5X3HJ": return 31
    case "M6V2BQ": return 32
    case "F9P7DW": return 33
    case "L3N1YQ": return 34
    case "A3B8TX": return 35
    case "E4K9UA": return 36
    case "Q7V2ZL": return 37
    case "S9R6IG": return 38
    case "T2J9FO": return 39
    case "U1Q5MK": return 40
    case "Y8D3EG": return 41
    case "Z6W4VS": return 42
    case "C7F1LR": return 43
    case "I5N2XP": return 44
    case "O4H7TY": return 45
    case "V9M8JN": return 46
    case "W3P6QK": return 47
    case "X6G5CD": return 48
    default: return 999
    }
}

extension Int {
    func asString() -> String {
        return "\(self)"
    }
}

func getFirstTwoNames(from fullName: String) -> String {
    let components = fullName.split(separator: " ")
        guard components.count >= 2 else {
            return fullName
        }
    let firstTwoNames = components.prefix(2).joined(separator: " ")
    return firstTwoNames
}
