//
//  MentorshipHomeService.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 21/05/24.
//

import Foundation

class MentorshipService {
    func isUserAMentor(userId: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            DispatchQueue.main.async {
                
                let mentors = MentorsManager.shared.getAllMentors()
                let thereIsUserId = mentors.first(where: {
                    $0.id.asString() == userId
                }) != nil
                completion(.success(thereIsUserId))
            }
        }
    }
    
    func changeMentoringStatus(wantToBeAmentor: Bool, completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            DispatchQueue.main.async {
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
}
