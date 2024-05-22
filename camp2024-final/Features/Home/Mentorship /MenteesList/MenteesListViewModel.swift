//
//  MenteesListViewModel.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 21/05/24.
//

import Foundation


class MenteesListViewModel: ObservableObject {
    @Published var mentees: [User] = []
    @Published var isLoading = true
    @Published var showAlert = false
    
    private let service = MenteesListService()
    
    func loadMentees() {
        isLoading = true
        let myUserId = UserSessionManager.shared.userId
        
        service.getMyMentees(userId: myUserId) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let mentees):
                self.mentees = mentees
            case .failure:
                self.showAlert = true
            }
        }
    }
}
