//
//  ViewController.swift
//  NoteApp
//
//  Created by Aryan Kapoor on 8/13/21.
//  Copyright © 2021 Aryan Kapoor. All rights reserved.
//

import UIKit


protocol DataDelegate{
    func updateArray(newArray: String)
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    var notesArray = [Note]()
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let vc = segue.destination as! AddNoteViewController
        
        if segue.identifier == "updateNoteSegue" {
            vc.note = notesArray[notesTableView.indexPathForSelectedRow!.row]
            vc.update=true
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath) as! NotePrototypeCell
        cell.title.text = notesArray[indexPath.row].title
        cell.note.text = notesArray[indexPath.row].note
        cell.date.text = notesArray[indexPath.row].date
        
       // cell.textLabel?.text = notesArray[indexPath.row].title
        return cell
    }
    

    @IBOutlet weak var notesTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        APIFunctions.functions.fetchNotes()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        APIFunctions.functions.fetchNotes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIFunctions.functions.delegate = self
        APIFunctions.functions.fetchNotes()
       // print(notesArray)
        
        notesTableView.delegate = self
        notesTableView.dataSource=self
        // Do any additional setup after loading the view.
    }


}


extension ViewController: DataDelegate
{
    
    func updateArray(newArray: String)
    {
       
        do{
            notesArray = try JSONDecoder().decode([Note].self,from: newArray.data(using: .utf8)!)
            
            
        } catch {
            
            print("Failed to decode!")
            
        }
        self.notesTableView?.reloadData()
    }
    
}

