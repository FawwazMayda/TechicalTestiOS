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
    var selectedBookId = 0
    var selectedBookGenre = ""
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToBookDetail" {
            let destVC = segue.destination as? BookDetailViewController
            destVC?.book_id = selectedBookId
            destVC?.genre = selectedBookGenre
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedBookId = bookByGenreData[indexPath.row].id
        selectedBookGenre = bookByGenreData[indexPath.row].Genre_by_genre_id.title
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ToBookDetail", sender: nil)
    }
    
    
    
    
}
