//
//  MentorRequisitionViewModel.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 21/05/24.
//

import Foundation


class MentorRequisitionViewModel: ObservableObject {
    @Published var mentors: [User] = []
    @Published var showAlert = false
    
    var alertType: AlertType = .mentorsLoadFailure
    var selectedMentor: User?
    
    enum AlertType {
        case mentorsLoadFailure
        case sendRequestFailure
        case requestSended
    }
    
    private var service: MentorRequisitionService
    var didFailMentoringStatusToggle = false
    
    init(service: MentorRequisitionService) {
        self.service = service
        loadMentors()
    }
    
    func loadMentors() {
        service.loadMentor { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure:
                self.alertType = .mentorsLoadFailure
            case .success(let mentors):
                self.filterMentors(mentors)
            }
        }
    }
    
    private func filterMentors(_ mentors: [User]) {
        guard let myUser = UserSessionManager.shared.loadUser() else {
            return
        }
        let filteredMentors = mentors
            .filter({
                $0.area == myUser.area && $0.id != myUser.id
            })
        self.mentors = filteredMentors
    }
    
    func sendRequest() {
       
    }
}
