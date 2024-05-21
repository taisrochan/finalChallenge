//
//  RequisitionsService.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 21/05/24.
//

import Foundation

class RequisitionsService {
    private let userDefaults = MentorsRequestManager.shared
    
    func getRequisitions(userId: Int, completion: @escaping (Result<[MentorRequestModel], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            DispatchQueue.main.async {
                let mentorings = self.userDefaults.getAllMentorings()
                let filteresMentorings = mentorings.filter({ $0.mentor.id == userId })
                completion(.success(filteresMentorings))
            }
        }
    }
    
    func updateRequest(didAccept: Bool, request: MentorRequestModel, completion: (Bool)->Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            DispatchQueue.main.async {
                let newModel = request.copyWith(newStatus: .alreadyAnswered)
                self.userDefaults.updateMentoring(request: request, newValue: newModel)
                let newStatus: MentoringStatus = didAccept ? .accepted : .rejected
                let answerModel = request.copyWith(newStatus: newStatus, date: Date.now)
                self.userDefaults.addAnswer(newRequest: answerModel)
            }
        }
    }
}
