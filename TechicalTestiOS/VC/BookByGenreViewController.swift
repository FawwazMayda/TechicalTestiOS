//
//  BookByGenreViewController.swift
//  TechicalTestiOS
//
//  Created by Muhammad Fawwaz Mayda on 14/06/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class BookByGenreViewController: UIViewController {

    var genre_id = 0
    let ng = NetReq()
    var bookByGenreData = [Book]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        ng.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ng.reqBookByGenre(genre_id: genre_id)
    }

}

extension BookByGenreViewController: NetReqDelegate {
    func didGetBookByGenre(data: [Book]) {
        DispatchQueue.main.async {
            self.bookByGenreData = data
            self.tableView.reloadData()
        }
    }
}
extension BookByGenreViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookByGenreData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookByGenreCell", for: indexPath)
        cell.textLabel?.text = bookByGenreData[indexPath.row].title
        return cell
    }
    
    
    
    
}
