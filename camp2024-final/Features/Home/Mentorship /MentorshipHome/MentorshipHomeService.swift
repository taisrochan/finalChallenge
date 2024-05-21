//
//  MentorshipHomeService.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 21/05/24.
//

import Foundation

class MentorshipService {
    func changeMentoringStatus(wantToBeAmentor: Bool, completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if wantToBeAmentor {
                if let user = UserSessionManager.shared.loadUser() {
                    MentorsManager.shared.addMentor(user)
                }
            } else {
                MentorsManager.shared.removeMentor(by: UserSessionManager.shared.userId)
            }
        }
    }
}
