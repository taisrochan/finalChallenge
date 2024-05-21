//
//  RequisitionRowView.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 21/05/24.
//

import Foundation

import SwiftUI

struct RequisitionRowView: View {
    private let request: MentorRequestModel
    private let dateFormatter: DateFormatter
    
    init(request: MentorRequestModel) {
        self.request = request
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateStyle = .short
        self.dateFormatter.timeStyle = .short
    }
    
    private var menteeName: String {
        return getFirstTwoNames(from: request.mentee.name)
    }
    
    private var statusInfo: (String, String, Color) {
        switch request.status {
        case MentoringStatus.requested.rawValue:
            return ("Nova solicitação", "\(menteeName) solicitou sua mentoria", .green)
        case MentoringStatus.accepted.rawValue:
            return ("Mentoria aceita", "Você aceitou monitorar \(menteeName)", .blue)
        case MentoringStatus.rejected.rawValue:
            return ("Mentoria rejeitada", "Você rejeitou o pedido de \(menteeName)", .red)
        case MentoringStatus.finished.rawValue:
            return ("Mentoria finalizada", "Essa monitoria foi encerrada", .gray)
        case MentoringStatus.alreadyAnswered.rawValue:
            return ("Solicitação", "\(menteeName) solicitou sua mentoria", .gray)
        default:
            return ("", "", .clear)
        }
    }
    
    var body: some View {
        HStack {
            Circle()
                .fill(statusInfo.2)
                .frame(width: 10, height: 10)
                .padding(.trailing, 8)
            
            VStack(alignment: .leading) {
                Text(statusInfo.0)
                    .font(.headline)
                Text(statusInfo.1)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("Data: \(request.date, formatter: dateFormatter)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 8)
            
            if request.status == MentoringStatus.requested.rawValue {
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
    }
}
