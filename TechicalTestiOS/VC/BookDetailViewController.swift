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
    var writerId = 0
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

                
                let htmlData = Data(bookDetail.synopsis.utf8)
                if let attributedString = try? NSAttributedString(data: htmlData, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                    self.bookSynopsis.attributedText = attributedString
                }

                
                self.bookWriterButton.setTitle(bookDetail.Writer_by_writer_id.User_by_user_id.name, for: .normal)
                if var coverURL = self.currentBookDetail?.cover_url {
                    let index = coverURL.index(coverURL.startIndex, offsetBy: 9)
                    let urlSubStr = coverURL.suffix(from: index)
                    self.getImageFromUrl(imgURL: String(urlSubStr),for: self.bookImageView)
                }
            }
        }
    }
    
    func getImageFromUrl(imgURL: String,for img: UIImageView) {
        let url = "https://cabaca.id:8443/api/v2/files/covers/\(imgURL)&api_key=32ded42cfffb77dee86a29f43d36a3641849d4b5904aade9a79e9aa6cd5b5948"
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
    
    @IBAction func writerButtonTapped(_ sender: Any) {
        writerId = currentBookDetail?.Writer_by_writer_id.User_by_user_id.id as! Int
        performSegue(withIdentifier: "ToWriterDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToWriterDetail" {
            let destVC = segue.destination as? WriterDetailViewController
            destVC?.writerId = writerId
        }
    }
}

extension BookDetailViewController: NetReqDelegate {
    func didGetBookDetail(data: BookDetail) {
        currentBookDetail = data
        setView()
    }
}
