//
//  SecondViewController.swift
//  TechicalTestiOS
//
//  Created by Muhammad Fawwaz Mayda on 14/06/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var thisGenreTitle = ""
    var selected_genre_id = 0
    let ng = NetReq()
    var forData = [Genre]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ng.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ng.reqGenre()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GenreToBook" {
            let destVC = segue.destination as? BookByGenreViewController
            destVC?.genre_id = selected_genre_id
            destVC?.genreTitle = thisGenreTitle
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected_genre_id = forData[indexPath.row].id
        thisGenreTitle = forData[indexPath.row].title
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "GenreToBook", sender: nil)
    }
}
