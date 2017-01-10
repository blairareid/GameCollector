//
//  ViewController.swift
//  GameCollector
//
//  Created by Blair Reid on 2017-01-09.
//  Copyright © 2017 Blair Reid. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var games : [Game] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Get context to store
        let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            games = try context.fetch(Game.fetchRequest())  // data will be loaded from store
            tableView.reloadData()  // Reload data for table view
        } catch {
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      // Executed for every row of the tableview
        let cell = UITableViewCell()
        
        let game = games[indexPath.row]
        
        cell.textLabel?.text = game.title
        cell.imageView?.image = UIImage(data: game.image as! Data) //Need to covert to image as stored as binary data
        
        return cell
        
    }
    
    
}
