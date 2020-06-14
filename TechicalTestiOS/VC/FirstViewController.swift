//
//  FirstViewController.swift
//  TechicalTestiOS
//
//  Created by Muhammad Fawwaz Mayda on 14/06/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    let ng = NetReq()
    var updateData = [BookUpdate]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        ng.delegate = self
        ng.reqBookUpdate(limit: 7)
        // Do any additional setup after loading the view.
    }


}

extension FirstViewController: NetReqDelegate {
    func didGetBookUpdate(data: [BookUpdate]) {
        DispatchQueue.main.async {
            self.updateData = data
            self.tableView.reloadData()
        }
    }
}

extension FirstViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return updateData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookUpdateCell", for: indexPath)
        cell.textLabel?.text = updateData[indexPath.row].title
        return cell
    }
    
    
}

