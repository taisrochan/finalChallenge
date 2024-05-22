//
//  MenteesListService.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 21/05/24.
//

import Foundation


class MenteesListService {
    private let userDefaults = MentorsRequestManager.shared
    
    func getMyMentees(userId: Int, completion: @escaping (Result<[User], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            DispatchQueue.main.async {
                let mentorings = self.userDefaults.getAllMentorings()
                let filteresMentorings = mentorings.filter({
                    $0.mentor.id == userId && $0.status == MentoringStatus.accepted.rawValue
                })
                let mentees = filteresMentorings.map { $0.mentee }
                completion(.success(mentees))
            }
        }
    }
}
