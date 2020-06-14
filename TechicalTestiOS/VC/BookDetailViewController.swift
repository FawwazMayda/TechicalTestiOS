//
//  BookDetailViewController.swift
//  TechicalTestiOS
//
//  Created by Muhammad Fawwaz Mayda on 14/06/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var bookImageView: UIImageView!
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookGenre: UILabel!
    @IBOutlet weak var bookWriterButton: UIButton!
    @IBOutlet weak var bookSynopsis: UILabel!
    let ng = NetReq()
    var book_id = 0
    var genre = ""
    var currentBookDetail : BookDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ng.delegate = self

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ng.reqBookByDetail(book_id: book_id)
    }
    
    func setView() {
        if let bookDetail = currentBookDetail {
            DispatchQueue.main.async {
                self.bookTitle.text = bookDetail.title
                self.bookGenre.text = self.genre
                self.bookWriterButton.setTitle(bookDetail.Writer_by_writer_id.User_by_user_id.name, for: .normal)
                if var coverURL = self.currentBookDetail?.cover_url {
                    let index = coverURL.index(coverURL.startIndex, offsetBy: 9)
                    let urlSubStr = coverURL.suffix(from: index)
                    self.getImageFromUrl(imgURL: String(urlSubStr))
                }
            }
        }
    }
    
    func getImageFromUrl(imgURL: String) {
        let url = "https://cabaca.id:8443/api/v2/files/covers/\(imgURL)&api_key=32ded42cfffb77dee86a29f43d36a3641849d4b5904aade9a79e9aa6cd5b5948"
        let urlRequests = URL(string: url)!
        let dataTask = URLSession.shared.dataTask(with: urlRequests) { (data, resp, error) in
            if let imgData = data {
                DispatchQueue.main.async {
                    self.bookImageView.image = UIImage(data: imgData)
                }
            }
        }
        dataTask.resume()
    }
    
    @IBAction func writerButtonTapped(_ sender: Any) {
    }
}

extension BookDetailViewController: NetReqDelegate {
    func didGetBookDetail(data: BookDetail) {
        currentBookDetail = data
        setView()
    }
}
