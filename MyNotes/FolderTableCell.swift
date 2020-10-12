//
//  FolderTableCell.swift
//  MyNotes
//
//  Created by Ankur on 29/03/20.
//  Copyright © 2020 Ankur. All rights reserved.
//

import UIKit

class FolderTableCell: UITableViewCell
{
    @IBOutlet weak private var iconWrapperView: UIView!
    @IBOutlet weak private var folderIconImageView: UIImageView!
    @IBOutlet weak private var folderName: UILabel!
    @IBOutlet weak private var noteCount: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setFolderDtls(_ folderDtl: FolderDetail)
    {
        self.folderName.text = folderDtl.folderName
        self.noteCount.text = folderDtl.noteDtlArr.count.description
    }
}
