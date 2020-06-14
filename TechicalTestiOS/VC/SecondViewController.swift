//
//  SecondViewController.swift
//  TechicalTestiOS
//
//  Created by Muhammad Fawwaz Mayda on 14/06/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    let ng = NetReq()
    var forData = [Genre]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ng.delegate = self
        _ = ng.reqGenre()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
}

extension SecondViewController: NetReqDelegate {
    func didGetGenre(data: [Genre]) {
        DispatchQueue.main.async {
             self.forData = data
             self.tableView.reloadData()
        }
    }
}
extension SecondViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenreCell", for: indexPath)
        cell.textLabel?.text = forData[indexPath.row].title
        return cell
    }
    
    
    
}
