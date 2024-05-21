//
//  MentorRequisitionService.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 21/05/24.
//

import Foundation

class MentorRequisitionService {
    
    func loadMentor(completion: @escaping (Result<[User], Error>)->Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let mentors = MentorsManager.shared.getAllMentors()
            completion(.success(mentors))
        }
    }
}
