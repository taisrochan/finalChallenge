//
//  methods.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 21/05/24.
//

import SwiftUI

func convertCodeToUserId(code: String) -> Int {
    switch code.uppercased() {
    case "B5P7TR": return 4
    case "H2L9YC": return 5
    case "F8T6QD": return 6
    case "K4N3ZM": return 7
    case "W1B9JV": return 8
    case "R2M7GH": return 9
    case "X5L3PN": return 10 
    case "J7Q2WF": return 11
    case "D8V5LT": return 12
    case "P4K6YB": return 13
    case "N1Z8CR": return 14
    case "G5X3HJ": return 15
    case "M6V2BQ": return 16
    case "F9P7DW": return 17
    case "L3N1YQ": return 18
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
