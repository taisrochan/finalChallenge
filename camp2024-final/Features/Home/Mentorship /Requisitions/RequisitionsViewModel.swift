//
//  RequisitionsViewModel.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 21/05/24.
//

import Foundation

class RequisitionsViewModel: ObservableObject {
    @Published var requests: [MentorRequestModel] = []
    @Published var isLoading = true
    @Published var showAlert = false
    
    private let service = RequisitionsService()
    
    func loadRequests() {
        isLoading = true
        let myUserId = UserSessionManager.shared.userId
        service.getRequisitions(userId: myUserId) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let mentorings):
                self.requests = mentorings.sorted { $0.date > $1.date }
            case .failure:
                self.showAlert = true
            }
        }
    }
    
    func acceptRequest(_ request: MentorRequestModel) {
        isLoading = true
        service.updateRequest(didAccept: true, request: request) { _ in
            loadRequests()
        }
    }
    
    func rejectRequest(_ request: MentorRequestModel) {
        isLoading = true
        service.updateRequest(didAccept: false, request: request) { _ in
            loadRequests()
        }
    }
}
