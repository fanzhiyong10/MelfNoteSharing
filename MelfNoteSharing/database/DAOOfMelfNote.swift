//
//  DAOOfMelfNote.swift
//  M-Elf
//
//  Created by 范志勇 on 2022/8/21.
//  Copyright © 2022 范志勇. All rights reserved.
//

import Foundation
import os.log

/// 数据库操作：melfNote
///
/// 操作
/// - 插入
/// - 更新
/// - 查询
/// - 删除
/// - 整理？：待定
class DAOOfMelfNote {
    /*
    /// 回课笔记：删除 某个 笔记
    static func deleteOneMelfNote(melfNote: Subject) -> Bool {
        // 测试
        let info = "删除回课笔记"
        os_log("%{public}@ %{public}@", log: Log.database, type: .debug, #function, info)
        
        var result = true
        let createTime = melfNote.createTime!
        let iduser = melfNote.iduser!

        let dbQueue = FMDatabaseQueue(path: DatabaseSpecification.dbpathOfMelfNoteSharing)
        let sql = "DELETE FROM melfNote WHERE iduser = ? AND createTime = ?"
        dbQueue?.inTransaction{ db, rollback in
            // 删除
            do {
                try db.executeUpdate(sql, values: [iduser, createTime])
            } catch {
                rollback.pointee = true
                result = false
            }
        }

        return result
    }
    */
    /// 回课笔记：未归档的
    ///
    /// 结果
    /// - 文本
    /// - 声音
    /// - 照片
    /// - 视频
    /*
    static func searchUnarchivedNote() -> (text: Int, sound: Int, image: Int, video: Int) {
        // 测试
        let info = "查询数据库"
        os_log("%{public}@ %{public}@", log: Log.database, type: .debug, #function, info)
        
        let dbQueue = FMDatabaseQueue(path: DatabaseSpecification.dbpathOfMelfNote)
        // 查询数据库
        var textCount = 0
        var soundCount = 0
        var imageCount = 0
        var videoCount = 0

        let iduser = SettingsBundleHelper.fetchUserID()
//        let sqlString = "SELECT * FROM melfNote WHERE iduser = ?"
        let sqlString = """
SELECT \
COUNT(CASE WHEN melfNoteType = 0 THEN '1' END) textCount, \
COUNT(CASE WHEN melfNoteType = 1 THEN '1' END) soundCount, \
COUNT(CASE WHEN melfNoteType = 2 THEN '1' END) imageCount, \
COUNT(CASE WHEN melfNoteType = 3 THEN '1' END) videoCount \
FROM melfNote \
WHERE iduser = ?;
"""
        dbQueue?.inDatabase{ db in
            if let rs = db.executeQuery(sqlString, withArgumentsIn:[iduser]) {
                while rs.next() {
                    
                    // 测试
                    //                    printLog("乐谱：\(String(describing: scoreBasicInfo.id))")
                    textCount = rs["textCount"] as? Int ?? 0
                    soundCount = rs["soundCount"] as? Int ?? 0
                    imageCount = rs["imageCount"] as? Int ?? 0
                    videoCount = rs["videoCount"] as? Int ?? 0
                }
                
                rs.close()
                
            }
        }
        
        // 关闭
        dbQueue?.close()
        
        return (text: textCount, sound: soundCount, image: imageCount, video: videoCount)
    }
    */
    /*
    /// 删除未归档的所有笔记
    static func deleteAllMelfNote() -> Bool {
        // 测试
        let info = "删除回课笔记"
        os_log("%{public}@ %{public}@", log: Log.database, type: .debug, #function, info)
        
        var result = true
        let iduser = SettingsBundleHelper.fetchUserID()

        let dbQueue = FMDatabaseQueue(path: DatabaseSpecification.dbpathOfMelfNote)
        let sql = "DELETE FROM melfNote WHERE iduser = ? AND archived = 0"
        dbQueue?.inTransaction{ db, rollback in
            // 删除
            do {
                try db.executeUpdate(sql, values: [iduser])
            } catch {
                rollback.pointee = true
                result = false
            }
        }

        return result
    }
    */
/*
    /// 删除：未归档的、满足自动清理的时间 所有笔记
    static func deleteAllMelfNoteAfterAutuoCleanTime() -> Bool {
        // 测试
        let info = "删除回课笔记"
        os_log("%{public}@ %{public}@", log: Log.database, type: .debug, #function, info)
        
        var result = true
        let iduser = SettingsBundleHelper.fetchUserID()

        let int_now = Int(Date().timeIntervalSince1970) // 当前时间

        // 自动清理的时间间隔：换算为秒
        let gap_second = SettingsBundleHelper.fetchAutoCleanTime() * 3600
        
        let dbQueue = FMDatabaseQueue(path: DatabaseSpecification.dbpathOfMelfNote)
        let sql = "DELETE FROM melfNote WHERE iduser = ? AND archived = 0 AND (createTime + ?) < ?"
        dbQueue?.inTransaction{ db, rollback in
            // 删除
            do {
                try db.executeUpdate(sql, values: [iduser, gap_second, int_now])
            } catch {
                rollback.pointee = true
                result = false
            }
        }

        return result
    }
    */
/*
    /// 删除未归档的笔记：类型
    static func deleteAllMelfNote(melfNoteType: Int) -> Bool {
        // 测试
        let info = "删除回课笔记"
        os_log("%{public}@ %{public}@", log: Log.database, type: .debug, #function, info)
        
        var result = true
        let iduser = SettingsBundleHelper.fetchUserID()

        let dbQueue = FMDatabaseQueue(path: DatabaseSpecification.dbpathOfMelfNote)
        let sql = "DELETE FROM melfNote WHERE iduser = ? AND archived = 0  AND melfNoteType = ? "
        dbQueue?.inTransaction{ db, rollback in
            // 删除
            do {
                try db.executeUpdate(sql, values: [iduser, melfNoteType])
            } catch {
                rollback.pointee = true
                result = false
            }
        }

        return result
    }
    */
    
    /*
    /// 查询未归档的笔记：类型
    static func searchAllMelfNote(melfNoteType: Int) -> [String] {
        // 测试
        let info = "删除回课笔记"
        os_log("%{public}@ %{public}@", log: Log.database, type: .debug, #function, info)
        
        var result = [String]()
        let iduser = SettingsBundleHelper.fetchUserID()

        let dbQueue = FMDatabaseQueue(path: DatabaseSpecification.dbpathOfMelfNote)
        let sql = "SELECT content FROM melfNote WHERE iduser = ? AND archived = 0  AND melfNoteType = ? "
        
        dbQueue?.inDatabase{ db in
            if let rs = db.executeQuery(sql, withArgumentsIn:[iduser, melfNoteType]) {
                while rs.next() {
                    
                    if let content = rs["content"] as? String {
                        result.append(content)
                    }
                }
                
                rs.close()
                
            }
        }

        return result
    }
    */
    
    /*
    /// 所有有媒体的笔记：声音、照片、视频
    static func searchAllMelfNoteWithMedia() -> [String] {
        // 测试
        let info = "删除回课笔记"
        os_log("%{public}@ %{public}@", log: Log.database, type: .debug, #function, info)
        
        var result = [String]()
        let iduser = SettingsBundleHelper.fetchUserID()

        let dbQueue = FMDatabaseQueue(path: DatabaseSpecification.dbpathOfMelfNote)
        let sql = "SELECT content FROM melfNote WHERE iduser = ? AND archived = 0  AND melfNoteType <> 0 "
        
        dbQueue?.inDatabase{ db in
            if let rs = db.executeQuery(sql, withArgumentsIn:[iduser]) {
                while rs.next() {
                    
                    if let content = rs["content"] as? String {
                        result.append(content)
                    }
                }
                
                rs.close()
                
            }
        }

        return result
    }
    */
    /*
    /// 所有有媒体的笔记：声音、照片、视频，满足自动清理的时间
    static func searchAllMelfNoteWithMediaAfterAutuoCleanTime() -> [String] {
        // 测试
        let info = "查询回课笔记：所有有媒体的笔记：声音、照片、视频，满足自动清理的时间"
        os_log("%{public}@ %{public}@", log: Log.database, type: .debug, #function, info)
        
        var result = [String]()
        let iduser = SettingsBundleHelper.fetchUserID()
        let int_now = Int(Date().timeIntervalSince1970) // 当前时间

        // 自动清理的时间间隔：换算为秒
        let gap_second = SettingsBundleHelper.fetchAutoCleanTime() * 3600
        
        let dbQueue = FMDatabaseQueue(path: DatabaseSpecification.dbpathOfMelfNote)
        let sql = "SELECT content, createTime FROM melfNote WHERE iduser = ? AND archived = 0  AND melfNoteType <> 0 AND (createTime + ?) < ? "
        
        dbQueue?.inDatabase{ db in
            if let rs = db.executeQuery(sql, withArgumentsIn:[iduser, gap_second, int_now]) {
                while rs.next() {
                    
                    if let content = rs["content"] as? String {
                        result.append(content)
                    }
                }
                
                rs.close()
                
            }
        }

        return result
    }
    */
    /// 插入新的subject
    static func insertNewMelfSubject(melfSubject: Subject) -> Bool {
        var result = true
        
        // 测试
        os_log("%{public}@ %{public}@", log: Log.database, type: .debug, #function, "\(melfSubject)")
        
        let dbQueue = FMDatabaseQueue(path: DatabaseSpecification.dbpathOfMelfNoteSharing)
        
        // 插入到数据库
        dbQueue?.inTransaction{ db, rollback in
            do {
                let id_subject = melfSubject.id_subject ?? 100
                let catalog = melfSubject.catalog ?? ""
                let title = melfSubject.title ?? ""
                let description = melfSubject.description ?? ""
                
                let postMan = melfSubject.postMan ?? ""
                let postTime = melfSubject.postTime ?? -100

                
                // 插入
                try db.executeUpdate("insert into subject (id_subject, catalog, title, description, postMan, postTime) values (?,?,?,?,?,?)", values:[id_subject, catalog, title, description, postMan, postTime])
                
                // 存储数量
                if let rs = db.executeQuery("select count(*) from subject", withArgumentsIn:[]) {
                    while rs.next() {
                        let info = "数量：\(String(describing: rs[0]))"
                        os_log("%{public}@", log: Log.database, type: .debug, info)
                    }
                    
                    rs.close()
                }
            } catch {
                rollback.pointee = true
                result = false
            }
        }
        
        // 关闭
        dbQueue?.close()
        
        return result
    }
    
    /// 插入新的feedback
    static func insertNewFeedback(_ feedback: FeedBack) -> Bool {
        var result = true
        
        // 测试
        os_log("%{public}@ %{public}@", log: Log.database, type: .debug, #function, "\(feedback)")
        
        let dbQueue = FMDatabaseQueue(path: DatabaseSpecification.dbpathOfMelfNoteSharing)
        
        // 插入到数据库
        dbQueue?.inTransaction{ db, rollback in
            do {
                let id_subject = feedback.id_subject ?? 100
                let positive = feedback.positive ?? ""
                let negative = feedback.negative ?? ""

                let postTime = feedback.postTime ?? -100

                
                // 插入
                try db.executeUpdate("insert into feedback (id_subject, positive, negative, postTime) values (?,?,?,?)", values:[id_subject, positive, negative, postTime])
                
                // 存储数量
                if let rs = db.executeQuery("select count(*) from feedback", withArgumentsIn:[]) {
                    while rs.next() {
                        let info = "数量：\(String(describing: rs[0]))"
                        os_log("%{public}@", log: Log.database, type: .debug, info)
                    }
                    
                    rs.close()
                }
            } catch {
                rollback.pointee = true
                result = false
            }
        }
        
        // 关闭
        dbQueue?.close()
        
        return result
    }
    
    /// 找到最大id，用于主键
    static func searchMaxID() -> Int {
        // 测试
        let info = "查询数据库"
        os_log("%{public}@ %{public}@", log: Log.database, type: .debug, #function, info)
        
        let dbQueue = FMDatabaseQueue(path: DatabaseSpecification.dbpathOfMelfNoteSharing)
        // 查询数据库
        var maxID = 0
        let sqlString = "SELECT MAX(id_subject) AS max_id FROM subject"
        
        dbQueue?.inDatabase{ db in
            if let rs = db.executeQuery(sqlString, withArgumentsIn:[]) {
                while rs.next() {
                    
                    if let max_id = rs["max_id"] as? Int {
                        maxID = max_id
                    }
                }
                
                rs.close()
                
            }
        }
        
        // 关闭
        dbQueue?.close()
        
        return maxID
    }
    
    /*
    /// 回课笔记：更新
    ///
    /// 可能的更新项
    /// - content
    /// - createTime
    /// - 移动位置，更新：indexOfMeasure，indexOfNote
    static func updateMelfNote(new melfNote: MelfNote, old: MelfNote) -> Bool {
        var result = true
        
        // 测试
        os_log("%{public}@", log: Log.database, type: .debug, #function)
        
        let dbQueue = FMDatabaseQueue(path: DatabaseSpecification.dbpathOfMelfNote)
        
        // 插入到数据库
        dbQueue?.inTransaction{ db, rollback in
            do {
                let iduser = melfNote.iduser ?? 0
                let idscore = melfNote.idscore!
                let indexOfMeasure = melfNote.indexOfMeasure ?? -100
                let indexOfNote = melfNote.indexOfNote ?? -100
                let content = melfNote.content ?? "-100"
                let createTime = melfNote.createTime!
                let createTime_old = old.createTime!
                let archived = melfNote.archived ?? 0

                
                do {
                    // 测试
                    let info = melfNote.description
                    os_log("%{public}@  %{public}@", log: Log.database, type: .debug, #function, info)
                }
                
                
                // 插入
                try db.executeUpdate("UPDATE melfNote SET indexOfMeasure = ?, indexOfNote = ?, content = ?, createTime = ?, archived = ? WHERE idscore = ? AND createtime = ? AND iduser = ?", values:[indexOfMeasure, indexOfNote, content, createTime, archived, idscore, createTime_old, iduser])
                
                // 存储数量
                if let rs = db.executeQuery("select count(*) from melfNote", withArgumentsIn:[]) {
                    while rs.next() {
                        //                        print("数量：\(String(describing: rs[0]))")
                        let info = "数量：\(String(describing: rs[0]))"
                        os_log("%{public}@", log: Log.database, type: .debug, info)
                    }
                    
                    rs.close()
                }
            } catch {
                rollback.pointee = true
                result = false
            }
        }
        
        // 关闭
        dbQueue?.close()
        
        return result
    }
    */
    /*
    /// 所有回课笔记：用户id
    ///
    /// 参数
    /// - parameter idscore: 乐谱
    /// - parameter uif: 用户
    static func searchAllMelfNotes(idscore: Int, uid: Int) -> [MelfNote]? {
        // 测试
        let info = "查询数据库"
        os_log("%{public}@ %{public}@", log: Log.database, type: .debug, #function, info)
        
        let dbQueue = FMDatabaseQueue(path: DatabaseSpecification.dbpathOfMelfNote)
        // 查询数据库
        var melfNotes = [MelfNote]()
        
        let iduser = uid
        let sqlString = "SELECT * FROM melfNote WHERE iduser = ? AND idscore = \(idscore) ORDER BY createTime DESC;"
        dbQueue?.inDatabase{ db in
            if let rs = db.executeQuery(sqlString, withArgumentsIn:[iduser]) {
                while rs.next() {
                    
                    // 测试
                    //                    printLog("乐谱：\(String(describing: scoreBasicInfo.id))")
                    let melfNote = toMelfNote(rs: rs)
                    
                    // 加入数组
                    melfNotes += [melfNote]
                }
                
                rs.close()
                
            }
        }
        
        // 关闭
        dbQueue?.close()
        
        if melfNotes.count >= 1 {
            return melfNotes
        } else {
            return nil
        }
        
    }
    */
    
    

    
    
    static func searchAllMelfSubjects() -> [Subject]? {
        // 测试
        let info = "查询数据库"
        os_log("%{public}@ %{public}@", log: Log.database, type: .debug, #function, info)
        
        let dbQueue = FMDatabaseQueue(path: DatabaseSpecification.dbpathOfMelfNoteSharing)
        // 查询数据库
        var melfSubjects = [Subject]()
        
//        let sqlString = "SELECT * FROM subject ORDER BY postTime DESC;"
        let sqlString = "SELECT subject.*, (SELECT COUNT(*) FROM feedback WHERE feedback.id_subject = subject.id_subject) AS count_feedback  FROM  subject ORDER BY postTime DESC;"
        dbQueue?.inDatabase{ db in
            if let rs = db.executeQuery(sqlString, withArgumentsIn:[]) {
                while rs.next() {
                    
                    // 测试
                    //                    printLog("乐谱：\(String(describing: scoreBasicInfo.id))")
                    let melfSubject = toMelfSubject(rs: rs)
                    
                    // 加入数组
                    melfSubjects += [melfSubject]
                }
                
                rs.close()
                
            }
        }
        
        // 关闭
        dbQueue?.close()
        
        if melfSubjects.count >= 1 {
            return melfSubjects
        } else {
            return nil
        }
        
    }
    
    static func searchAllMelfFeedBacks(id_subject: Int) -> [FeedBack]? {
        // 测试
        let info = "查询数据库"
        os_log("%{public}@ %{public}@", log: Log.database, type: .debug, #function, info)
        
        let dbQueue = FMDatabaseQueue(path: DatabaseSpecification.dbpathOfMelfNoteSharing)
        // 查询数据库
        var melfFeedBacks = [FeedBack]()
        
        let sqlString = "SELECT * FROM feedback ORDER BY postTime DESC;"
        dbQueue?.inDatabase{ db in
            if let rs = db.executeQuery(sqlString, withArgumentsIn:[]) {
                while rs.next() {
                    
                    let melfFeedBack = toMelfFeedBack(rs: rs)
                    
                    // 加入数组
                    melfFeedBacks += [melfFeedBack]
                }
                
                rs.close()
                
            }
        }
        
        // 关闭
        dbQueue?.close()
        
        if melfFeedBacks.count >= 1 {
            return melfFeedBacks
        } else {
            return nil
        }
        
    }
    
    /*
    /// 所有某个音符的回课笔记：用户id
    ///
    /// 参数
    /// - parameter idscore: 乐谱
    /// - parameter uif: 用户
    static func searchAllMelfNotes(idscore: Int, uid: Int, indexOfMeasure: Int, indexOfNote: Int) -> [MelfNote]? {
        // 测试
        let info = "查询数据库"
        os_log("%{public}@ %{public}@", log: Log.database, type: .debug, #function, info)
        
        let dbQueue = FMDatabaseQueue(path: DatabaseSpecification.dbpathOfMelfNote)
        // 查询数据库
        var melfNotes = [MelfNote]()
        
        let iduser = uid
        let sqlString = "SELECT * FROM melfNote WHERE iduser = ? AND idscore = ? AND indexOfMeasure = ? AND indexOfNote = ? ORDER BY createTime DESC;"
        dbQueue?.inDatabase{ db in
            if let rs = db.executeQuery(sqlString, withArgumentsIn:[iduser, idscore, indexOfMeasure, indexOfNote]) {
                while rs.next() {
                    
                    // 测试
                    //                    printLog("乐谱：\(String(describing: scoreBasicInfo.id))")
                    let melfNote = toMelfNote(rs: rs)
                    
                    // 加入数组
                    melfNotes += [melfNote]
                }
                
                rs.close()
                
            }
        }
        
        // 关闭
        dbQueue?.close()
        
        if melfNotes.count >= 1 {
            return melfNotes
        } else {
            return nil
        }
        
    }
    */
    /**
     # 查询结果
     1. 全表
     2. 排序：downloaded_time DESC
     */
    /*
    static func search() -> [MelfNote]? {
        // 测试
        let info = "查询数据库"
        os_log("%{public}@ %{public}@", log: Log.database, type: .debug, #function, info)
        
        let dbQueue = FMDatabaseQueue(path: DatabaseSpecification.dbpathOfMelfNote)
        // 查询数据库
        var melfNotes = [MelfNote]()
        dbQueue?.inDatabase{ db in
            if let rs = db.executeQuery("select * from melfNote ORDER BY createtime DESC", withArgumentsIn:[]) {
                while rs.next() {
                    
                    // 测试
                    //                    printLog("乐谱：\(String(describing: scoreBasicInfo.id))")
                    let melfNote = toMelfNote(rs: rs)

                    // 加入数组
                    melfNotes += [melfNote]
                }
                
                rs.close()
                
            }
        }
        
        // 关闭
        dbQueue?.close()
        
        if melfNotes.count >= 1 {
            return melfNotes
        } else {
            return nil
        }
    }
    */

    static func toMelfSubject(rs: FMResultSet) -> Subject {
        var melfSubject = Subject()
        melfSubject.id_subject = rs["id_subject"] as? Int
        melfSubject.catalog = rs["catalog"] as? String
        melfSubject.title = rs["title"] as? String
        melfSubject.description = rs["description"] as? String
        melfSubject.postMan = rs["postMan"] as? String
        melfSubject.postTime = rs["postTime"] as? Int
        melfSubject.count_feedback = rs["count_feedback"] as? Int

        return melfSubject
    }
    
    static func toMelfFeedBack(rs: FMResultSet) -> FeedBack {
        var melfFeedBack = FeedBack()
        melfFeedBack.id_subject = rs["id_subject"] as? Int
        melfFeedBack.positive = rs["positive"] as? String
        melfFeedBack.negative = rs["negative"] as? String
        melfFeedBack.postTime = rs["postTime"] as? Int

        return melfFeedBack
    }
    

}
