//
//  ViewController.swift
//  MyNotes
//
//  Created by Ankur on 28/03/20.
//  Copyright © 2020 Ankur. All rights reserved.
//

import UIKit

class MYNotesVC: UIViewController
{
    static func fromStoryboard(_ storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)) -> MYNotesVC
    {
        let controller = storyboard.instantiateViewController(withIdentifier: "MYNotesVC") as! MYNotesVC
        return controller
    }
    
    //private members
    @IBOutlet weak private var folderTableView: UITableView!
    @IBOutlet weak private var addFolderLbl: UILabel!
    
    //public members
    var notesHandler: NotesHandler = NotesHandler()
    
    override func viewDidLoad()
    {
        self.folderTableView.tableFooterView = UIView()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        //remove the folder details after coming back from folder detail screen(NotesListVC)
        self.removeDeletedFolder()
        self.folderTableView.reloadData()
    }
    
    @IBAction func addFolderHandler(_ sender: UIBarButtonItem)
    {
        let alert = UIAlertController(title: "My Notes", message: "Please enter Folder Name", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "My Folder"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            if let folderName = textField?.text, !(textField?.text!.isEmpty)!
            {
                self.notesHandler.appendFolderDetail(folderName)
            }
            self.folderTableView.reloadData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func searchHandler(_ sender: UIBarButtonItem)
    {
        //In progress
    }
    
    private func removeDeletedFolder()
    {
        notesHandler.folderDtlArr = notesHandler.folderDtlArr.filter { (folderDtl) -> Bool in
            return folderDtl.isDeleted == false
        }
    }
}

extension MYNotesVC: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let controller = NotesListVC.fromStoryboard()
        controller.folderDetail = notesHandler.folderDtlArr[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension MYNotesVC: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //hide or show label based on values in folder detail array
        if notesHandler.folderDtlArr.count == 0
        {
            addFolderLbl.isHidden = false
            tableView.isHidden = true
        }
        else
        {
            addFolderLbl.isHidden = true
            tableView.isHidden = false
        }
        return notesHandler.folderDtlArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: FolderTableCell = tableView.dequeueReusableCell(withIdentifier: "FolderTableCell") as! FolderTableCell
        cell.setFolderDtls(notesHandler.folderDtlArr[indexPath.row])
        return cell
    }
}


