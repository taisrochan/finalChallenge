//
//  MentorsManager.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 21/05/24.
//

import Foundation

class MentorsManager {
    static let shared = MentorsManager()

    private let mentorsKey = "mentors"
    private let userDefaults = UserDefaults.standard

    private init() {}

    func addMentor(_ user: User) {
        var mentors = getAllMentors()
        mentors.append(user)
        saveMentors(mentors)
    }

    func getAllMentors() -> [User] {
        if let data = userDefaults.data(forKey: mentorsKey),
           let mentors = try? JSONDecoder().decode([User].self, from: data) {
            let uniqueMentors = removeDuplicates(users: mentors)
            return uniqueMentors
            
        }
        return []
    }

    func removeMentor(by userId: Int) {
        var mentors = getAllMentors()
        mentors.removeAll { $0.id == userId }
        saveMentors(mentors)
    }

    private func saveMentors(_ mentors: [User]) {
        if let data = try? JSONEncoder().encode(mentors) {
            userDefaults.set(data, forKey: mentorsKey)
        }
    }
    
    private func removeDuplicates(users: [User]) -> [User] {
        var uniqueIds = [Int: Bool]()
        var uniqueUsers = [User]()
        for user in users {
            if uniqueIds[user.id] == nil {
                uniqueIds[user.id] = true
                uniqueUsers.append(user)
            }
        }
        return uniqueUsers
    }
}
