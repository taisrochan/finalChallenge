//
//  MentorsRequestManager.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 21/05/24.
//

import Foundation


class MentorsRequestManager {
    static let shared = MentorsRequestManager()
    
    private let key = "mentors-request"
    private let userDefaults = UserDefaults.standard
    
    private init() {}
    
    func addRequest(fromUser: User, toUser: User) {
        let model = MentorRequestModel(mentee: fromUser,
                                       mentor: toUser,
                                       status: MentoringStatus.requested.rawValue,
                                       date: Date.now)
        var mentorings = getAllMentorings()
        if mentorings.contains(model){
            return
        }
        mentorings.append(model)
        saveMentorings(mentorings)
    }
    
    func addAnswer(newRequest: MentorRequestModel) {
        var mentorings = getAllMentorings()
        if mentorings.contains(newRequest){
            return
        }
        mentorings.append(newRequest)
        saveMentorings(mentorings)
    }
    
    func getAllMentorings() -> [MentorRequestModel] {
        if let data = userDefaults.data(forKey: key),
           let mentorings = try? JSONDecoder().decode([MentorRequestModel].self, from: data) {
            return mentorings
            
        }
        return []
    }
    
    func updateMentoring(request: MentorRequestModel, newValue: MentorRequestModel) {
        var mentorings = getAllMentorings()
        if let index = mentorings.firstIndex(where: { $0 == request }) {
            mentorings[index] = newValue
            saveMentorings(mentorings)
        }
    }
    
    private func saveMentorings(_ mentors: [MentorRequestModel]) {
        if let data = try? JSONEncoder().encode(mentors) {
            userDefaults.set(data, forKey: key)
        }
    }
}

struct MentorRequestModel: Equatable, Codable, Identifiable {
    var id = UUID()
    
    let mentee: User
    let mentor: User
    let status: Int
    let date: Date
    
    static func ==(lhs: MentorRequestModel, rhs: MentorRequestModel) -> Bool {
        return lhs.mentee == rhs.mentee &&
        lhs.mentor == rhs.mentor &&
        lhs.status == rhs.status
    }
    
    func copyWith(newStatus: MentoringStatus, date: Date? = nil) -> MentorRequestModel {
        return MentorRequestModel(mentee: self.mentee,
                                  mentor: self.mentor,
                                  status: newStatus.rawValue,
                                  date: date ?? self.date)
    }
}
