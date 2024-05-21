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
            DispatchQueue.main.async {
                
                let mentors = MentorsManager.shared.getAllMentors()
                completion(.success(mentors))
            }
        }
    }
    
    func addRequest(fromUser mentee: User, toUser mentor: User, completion: @escaping (Bool)->Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            DispatchQueue.main.async {
                MentorsRequestManager.shared.addRequest(fromUser: mentee, toUser: mentor)
                completion(true)
            }
        }
    }
}
