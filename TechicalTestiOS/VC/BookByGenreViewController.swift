//
//  BookByGenreViewController.swift
//  TechicalTestiOS
//
//  Created by Muhammad Fawwaz Mayda on 14/06/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class BookByGenreViewController: UIViewController {

    var genreTitle = ""
    var genre_id = 0
    var selectedBookId = 0
    var selectedBookGenre = ""
    let ng = NetReq()
    var bookByGenreData = [Book]()
    
    @IBOutlet weak var genreLabel: UILabel!
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
        genreLabel.text = "Genre: \(genreTitle)"
        ng.reqBookByGenre(genre_id: genre_id)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToBookDetail" {
            let destVC = segue.destination as? BookDetailViewController
            destVC?.book_id = selectedBookId
            destVC?.genre = selectedBookGenre
        }
    }
    
    func getImageFromUrl(forCoverURL imgURL: String,for img: UIImageView) {
          let index = imgURL.index(imgURL.startIndex, offsetBy: 9)
          let urlSubStr = imgURL.suffix(from: index)
          let url = "https://cabaca.id:8443/api/v2/files/covers/\(urlSubStr)&api_key=32ded42cfffb77dee86a29f43d36a3641849d4b5904aade9a79e9aa6cd5b5948"
          let urlRequests = URL(string: url)!
          let dataTask = URLSession.shared.dataTask(with: urlRequests) { (data, resp, error) in
              if let imgData = data {
                  DispatchQueue.main.async {
                      img.image = UIImage(data: imgData)
                  }
              }
          }
          dataTask.resume()
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookByGenreCell", for: indexPath) as? BookByGenreCellTableViewCell else { fatalError("No Custom Cell")}
        cell.bookTitleLabel.text = bookByGenreData[indexPath.row].title
        getImageFromUrl(forCoverURL: bookByGenreData[indexPath.row].cover_url, for: cell.bookImageView)
        //cell.textLabel?.text = bookByGenreData[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedBookId = bookByGenreData[indexPath.row].id
        selectedBookGenre = bookByGenreData[indexPath.row].Genre_by_genre_id.title
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ToBookDetail", sender: nil)
    }
    
    
    
    
}
