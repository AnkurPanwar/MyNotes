//
//  NotesModel.swift
//  MyNotes
//
//  Created by Ankur on 29/03/20.
//  Copyright © 2020 Ankur. All rights reserved.
//

import Foundation

class NotesHandler
{
    var folderDtlArr: [FolderDetail] = []
    
    init(){}
        
    func appendFolderDetail(_ fldrDtl: String)
    {
        folderDtlArr.append((FolderDetail.init(fldrDtl)))
    }
    
}

class FolderDetail
{
    var folderName: String
    var notesCount: Int
    var noteDtlArr: [NoteDetail]
    var isDeleted: Bool
    
    init(_ fldrName: String)
    {
        folderName = fldrName
        notesCount = 0
        noteDtlArr = []
        isDeleted = false
    }
    
    func appendNoteDetail(_ ntDtl: NoteDetail)
    {
        noteDtlArr.append(ntDtl)
    }
}

class NoteDetail
{
    var noteTitle: String
    private var noteText: String?
    var lastSaved: String?
    var isDeleted: Bool
    
    init(_ ntTitl: String)
    {
        noteTitle = ntTitl
        isDeleted = false
        setLastSaved()
    }
    
    func setLastSaved()
    {
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        let second = components.second

        let today_string = String(year!) + "-" + String(month!) + "-" + String(day!) + " " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!)
        lastSaved = today_string
    }
    
    func saveNote(_ note: String)
    {
        noteText = note
    }
    
    func fetchNoteText() -> String
    {
        return noteText ?? ""
    }
}
