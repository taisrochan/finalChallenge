//
//  MentorshipHomeViewModel.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 21/05/24.
//

import SwiftUI

class MentorshipHomeViewModel: ObservableObject {
    @Published var wantToBeAMentorStatus = false
    @Published var isToggleDisabled = true
    @Published var showAlert = false
    
    private var service: MentorshipService
    var didFailMentoringStatusToggle = false
    var canPostChanging = true
    
    init(service: MentorshipService) {
        self.service = service
        setMentorStatus()
    }
    
    func changeMentoringStatus(wantToBeAmentor: Bool) {
        if wantToBeAmentor == false {
            showAlert = true
        } else {
            confirmMentoringStatusChange(wantToBeAmentor: wantToBeAmentor)
        }
    }
    
    func confirmMentoringStatusChange(wantToBeAmentor: Bool) {
        didFailMentoringStatusToggle = false
        wantToBeAMentorStatus = wantToBeAmentor
        
        service.changeMentoringStatus(wantToBeAmentor: wantToBeAmentor) { [weak self] result in
            guard let self = self else { return }
            isToggleDisabled = false
            switch result {
            case .failure:
                self.didFailMentoringStatusToggle = true
                self.showAlert = true
                self.wantToBeAMentorStatus = !self.wantToBeAMentorStatus
            default: break
            }
        }
    }
    
    func didPressCancel() {
        canPostChanging = false
        wantToBeAMentorStatus = true
        canPostChanging = true
    }
    
    private func setMentorStatus() {
        let userId = UserSessionManager.shared.userId
        service.isUserAMentor(userId: userId.asString()) { [weak self] result in
            guard let self = self else { return }
            self.isToggleDisabled = false
            switch result {
            case .success(let isUserAMentor):
                self.wantToBeAMentorStatus = isUserAMentor
            case .failure:
                self.wantToBeAMentorStatus = false
            }
        }
    }
}
