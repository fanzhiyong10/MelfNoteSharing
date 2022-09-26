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
    var postMan: String? = "JohnDoe"
    var postTime: Int?
    var count_feedback: Int? = 0 // feedback
    
    static func createData() -> [Subject] {
        var subjects = [Subject]()
        
        var subject = Subject()
        subject.id_subject = 0
        subject.catalog = "automotive"
        subject.title = "Refrigerated car trunks"
        subject.description = "Refrigerated car trunks with a freezer section in bigger vehicles like SUVs. \n\nIdeal for transportation of groceries requiring refrigeration, while in transit from supermarket to home."
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
    var id_subject: Int?
    var positive: String?
    var negative: String?
    var postTime: Int? = 0
    
    static func createData() -> [FeedBack] {
        var feedBacks = [FeedBack]()
        
        var feedBack = FeedBack()
        feedBack.id_subject = 0
        feedBack.positive = "Somewhat related, I remember hearing that some EV frunks are refrigenerated."
        feedBack.negative = "Only issue is that the trunk doesn't normally have any ventilation, so the inside of the fridge will get cool, but the rest of the trunk will cook."
        feedBacks.append(feedBack)
        
        do {
            var feedBack = FeedBack()
            feedBack.id_subject = 0
            feedBack.positive = "Somewhat related, I remember hearing that some EV frunks are refrigenerated."
            feedBack.negative = "Only issue is that the trunk doesn't normally have any ventilation, so the inside of the fridge will get cool, but the rest of the trunk will cook."
            feedBacks.append(feedBack)
        }
        
        return feedBacks
    }
}
