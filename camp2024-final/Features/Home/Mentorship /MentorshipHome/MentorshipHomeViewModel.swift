//
//  MentorshipHomeViewModel.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 21/05/24.
//

import SwiftUI

class MentorshipHomeViewModel: ObservableObject {
    @Published var wantToBeAMentorStatus = false
    @Published var isToggleDisabled = false
    @Published var showAlert = false
    
    private var service: MentorshipService
    var didFailMentoringStatusToggle = false
    
    init(service: MentorshipService) {
        self.service = service
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
        isToggleDisabled = true
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
}
