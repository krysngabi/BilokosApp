//
//  ViewController.swift
//  BilokosCollector
//
//  Created by Krys Ngabi on 6/15/20.
//  Copyright © 2020 Krys Ngabi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bilokosList.count
    }
    

    @IBOutlet weak var tabView: UITableView!
    
    var bilokosList : [TB_BILOKOS] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabView.delegate = self
        tabView.dataSource = self
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let bilokos = bilokosList[indexPath.row]
        cell.textLabel?.text = bilokos.title
        cell.imageView?.image = UIImage(data: bilokos.image as! Data)
        
        return cell
    }
    override func viewWillAppear(_ animated: Bool) {
        let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
        bilokosList = try context.fetch(TB_BILOKOS.fetchRequest())
            
            tabView.reloadData()
        } catch {
            
        }
    }


}

