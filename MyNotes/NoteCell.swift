//
//  NoteCell.swift
//  MyNotes
//
//  Created by Ankur on 29/03/20.
//  Copyright © 2020 Ankur. All rights reserved.
//

import UIKit

class NoteCell: UICollectionViewCell
{
    @IBOutlet weak private var noteCellWrapper: UIView!
    @IBOutlet weak private var noteTitleLbl: UILabel!
    @IBOutlet weak private var lastSavedLbl: UILabel!
    
    var setData: NoteDetail?
    {
        didSet
        {
            noteTitleLbl.text = setData?.noteTitle
            lastSavedLbl.text = setData?.lastSaved
        }
    }
}
