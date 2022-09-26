//
//  DatabaseSpecification.swift
//  M-Elf
//
//  Created by 范志勇 on 2018/3/28.
//  Copyright © 2018年 范志勇. All rights reserved.
//

import Foundation
import os.log

public struct Log {
    
    static var database = OSLog(subsystem: "com.yuejingling.melf.database", category: "database")
}



/**
 # 数据库说明及操作
 */
class DatabaseSpecification {
    // 存放目录
    static let directory = FileManager.SearchPathDirectory.applicationSupportDirectory
    
    // melfNoteSharingDBName
    static let melfNoteSharingDBName = "MelfNoteSharing" //melfNoteSharingDBName
    
    static let DBType = ".sqlite"
    static let melfNoteSharingDB = melfNoteSharingDBName + DBType

    // ====数据库 全局变量：pitchDeviations
    static var dbpathOfMelfNoteSharing : String {
        get {
            let docsdir = NSSearchPathForDirectoriesInDomains(directory, .userDomainMask, true).last!
            return (docsdir as NSString).appendingPathComponent(melfNoteSharingDB)
        }
    }
    
    static var hasMoved = false
    /**
     # 乐谱数据库：系统数据库
     1. 更新：通过网络访问服务器来更新
     */
    static func moveDatabase() {
        guard hasMoved == false else {
            return
        }
        return
        var srcPath:URL
        var destPath:URL
        let dirManager = FileManager.default
        let projectBundle = Bundle.main
        
        
        // ==== melfNoteDB
        do {
            let resourcePath = projectBundle.path(forResource: melfNoteSharingDBName, ofType: DBType)
            let documentURL = try dirManager.url(for: directory, in: .userDomainMask, appropriateFor: nil, create: true)
            srcPath = URL(fileURLWithPath: resourcePath!)
            destPath = documentURL.appendingPathComponent(melfNoteSharingDB)
            
            if !dirManager.fileExists(atPath: destPath.path) {
                let info = "not fileExists melfNoteSharingDB.sqlite"
                os_log("%{public}@", log: Log.database, type: .debug, info)
                try dirManager.copyItem(at: srcPath, to: destPath)
            } else {
                let info = "remove melfNoteSharingDB.sqlite"
                os_log("%{public}@", log: Log.database, type: .debug, info)
                try FileManager.default.removeItem(atPath: DatabaseSpecification.dbpathOfMelfNoteSharing) // in case we did this once already
                
                do {
                    let info = "melfNoteDB.sqlite"
                    os_log("%{public}@", log: Log.database, type: .debug, info)
                }
                try dirManager.copyItem(at: srcPath, to: destPath)
            }
            
            hasMoved = true
            
        } catch let err as NSError {
            print("Error: \(err.domain)")
        }
    }
}
