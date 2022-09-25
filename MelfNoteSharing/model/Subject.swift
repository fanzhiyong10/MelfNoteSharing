//
//  Subject.swift
//  MelfNoteSharing
//
//  Created by 范志勇 on 2022/9/25.
//

import Foundation
struct Subject {
    var id_subject: Int?
    var catalog: String?
    var title: String?
    var description: String?
    var postMan: String?
    var count_feedback: Int? = 0 // feedback
    
    static func createData() -> [Subject] {
        var subjects = [Subject]()
        
        var subject = Subject()
        subject.id_subject = 0
        subject.catalog = "automotive"
        subject.title = "Refrigerated car trunks"
        subject.description = ""
        subject.postMan = "JohnDoe"
        subject.count_feedback = 101
        subjects.append(subject)
        
        do {
            var subject = Subject()
            subject.id_subject = 1
            subject.catalog = "automotive"
            subject.title = "Refrigerated car trunks"
            subject.description = ""
            subject.postMan = "JohnDoe"
            subject.count_feedback = 101
            subjects.append(subject)
        }
        
        do {
            var subject = Subject()
            subject.id_subject = 2
            subject.catalog = "automotive"
            subject.title = "Refrigerated car trunks"
            subject.description = ""
            subject.postMan = "JohnDoe"
            subject.count_feedback = 101
            subjects.append(subject)
        }
        
        do {
            var subject = Subject()
            subject.id_subject = 3
            subject.catalog = "automotive"
            subject.title = "Refrigerated car trunks"
            subject.description = ""
            subject.postMan = "JohnDoe"
            subject.count_feedback = 101
            subjects.append(subject)
        }
        
        do {
            var subject = Subject()
            subject.id_subject = 4
            subject.catalog = "automotive"
            subject.title = "Refrigerated car trunks"
            subject.description = ""
            subject.postMan = "JohnDoe"
            subject.count_feedback = 101
            subjects.append(subject)
        }
        
        return subjects
    }
}

struct FeedBack {
    var positive: String?
    var negative: String?
}
