//
//  NotesListVC.swift
//  MyNotes
//
//  Created by Ankur on 29/03/20.
//  Copyright © 2020 Ankur. All rights reserved.
//

import UIKit

class NotesListVC: UIViewController
{
    static func fromStoryboard(_ storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)) -> NotesListVC
    {
        let controller = storyboard.instantiateViewController(withIdentifier: "NotesListVC") as! NotesListVC
        return controller
    }
    
    //private members
    @IBOutlet weak private var noteCollectionView: UICollectionView!
    @IBOutlet weak private var notesListNavBar: UINavigationBar!
    @IBOutlet weak private var addNoteLbl: UILabel!
    
    //public members
    var folderDetail: FolderDetail!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //set name of folder
        self.notesListNavBar.topItem?.title = folderDetail.folderName
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        //remove the note details after coming back from note description screen(NoteEditorVC)
        self.removeDeletedNote()
        self.noteCollectionView.reloadData()
    }
    
    @IBAction func backHandler(_ sender: UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addNoteHandler(_ sender: UIBarButtonItem)
    {
        let alert = UIAlertController(title: "My Notes", message: "Please Enter your note Title", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "My Title"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            if let noteTitle = textField?.text, !(textField?.text!.isEmpty)!
            {
                self.folderDetail.appendNoteDetail(NoteDetail.init(noteTitle))
            }
            self.noteCollectionView.reloadData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func deleteHandler(_ sender: UIBarButtonItem)
    {
        let deleteAlert = UIAlertController(title: "Alert", message: "Are you sure to delete the Folder!", preferredStyle: UIAlertController.Style.alert)

        deleteAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.folderDetail.isDeleted = true
              self.navigationController?.popViewController(animated: true)
        }))
        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        present(deleteAlert, animated: true, completion: nil)
    }

    private func removeDeletedNote()
    {
        folderDetail.noteDtlArr = folderDetail.noteDtlArr.filter { (noteDtl) -> Bool in
            noteDtl.isDeleted == false
        }
    }
}

extension NotesListVC: UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let controller = NoteEditerVC.fromStoryboard()
        controller.noteDetail = folderDetail.noteDtlArr[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension NotesListVC: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if folderDetail.noteDtlArr.count == 0
        {
            addNoteLbl.isHidden = false
            collectionView.isHidden = true
        }
        else
        {
            addNoteLbl.isHidden = true
            collectionView.isHidden = false
        }
        return folderDetail.noteDtlArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell: NoteCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteCell", for: indexPath) as! NoteCell
        cell.setData = folderDetail.noteDtlArr[indexPath.row]
        return cell
    }
}
