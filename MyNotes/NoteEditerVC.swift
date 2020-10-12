//
//  NoteEditerVC.swift
//  MyNotes
//
//  Created by Ankur on 29/03/20.
//  Copyright © 2020 Ankur. All rights reserved.
//

import UIKit

class NoteEditerVC: UIViewController
{
    static func fromStoryboard(_ storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)) -> NoteEditerVC
    {
        let controller = storyboard.instantiateViewController(withIdentifier: "NoteEditerVC") as! NoteEditerVC
        return controller
    }
    var noteDetail: NoteDetail?
    
    @IBOutlet weak private var noteTextView: UITextView!
    @IBOutlet weak private var noteEditerNavBar: UINavigationBar!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.noteEditerNavBar.topItem?.title = noteDetail?.noteTitle
        noteTextView.text = noteDetail?.fetchNoteText()
        noteTextView.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func backHandler(_ sender: UIBarButtonItem)
    {
        noteDetail?.setLastSaved()
        noteDetail?.saveNote(noteTextView.text)
        noteTextView.resignFirstResponder()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteHandler(_ sender: UIBarButtonItem)
    {
        let deleteAlert = UIAlertController(title: "Alert", message: "Are you sure to delete the note!", preferredStyle: UIAlertController.Style.alert)

        deleteAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
              self.noteDetail?.isDeleted = true
                  self.noteTextView.resignFirstResponder()
              self.navigationController?.popViewController(animated: true)
        }))

        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(deleteAlert, animated: true, completion: nil)
    }
}

