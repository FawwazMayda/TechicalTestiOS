//
//  WriterDetailViewController.swift
//  TechicalTestiOS
//
//  Created by Muhammad Fawwaz Mayda on 14/06/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class WriterDetailViewController: UIViewController {

    @IBOutlet weak var writerImageView: UIImageView!
    @IBOutlet weak var writerDescLabel: UILabel!
    @IBOutlet weak var writerPhoneLabel: UILabel!
    @IBOutlet weak var writerEmailLabel: UILabel!
    @IBOutlet weak var karyaTableView: UITableView!
    @IBOutlet weak var writerNameLabel: UILabel!
    
    var writerId = 0
    var selectedBookId = 0
    var currentWriterDetail: WriterDetail?
    let ng = NetReq()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        karyaTableView.delegate = self
        karyaTableView.dataSource = self
        ng.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ng.reqWriterDetail(writer_id: writerId)
    }
    
    func setupView() {
        DispatchQueue.main.async {
            self.writerNameLabel.text = self.currentWriterDetail?.name
            self.writerEmailLabel.text = self.currentWriterDetail?.email
            self.writerPhoneLabel.text = self.currentWriterDetail?.phone
            self.writerDescLabel.text = self.currentWriterDetail?.deskripsi
            
            self.getImageFromUrl(imgURL: self.currentWriterDetail!.photo_url, for: self.writerImageView)
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
    
    func getImageFromUrl(imgURL: String,for img: UIImageView) {
         let url = "https://cabaca.id:8443/api/v2/files/\(imgURL)&api_key=32ded42cfffb77dee86a29f43d36a3641849d4b5904aade9a79e9aa6cd5b5948"
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="ToBookDetail" {
            let destVC = segue.destination as? BookDetailViewController
            destVC?.book_id = selectedBookId
        }
    }
}

extension WriterDetailViewController: NetReqDelegate {
    func didGetWriterDetail(data: WriterDetail) {
        self.currentWriterDetail = data
        DispatchQueue.main.async {
            self.setupView()
            self.karyaTableView.reloadData()
        }
    }
}
extension WriterDetailViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentWriterDetail?.karya.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = karyaTableView.dequeueReusableCell(withIdentifier: "KaryaCell", for: indexPath) as? KaryaTableViewCell else {fatalError("No Custom cell")}
        cell.karyaLabel.text = currentWriterDetail?.karya[indexPath.row].title
        
        getImageFromUrl(forCoverURL: (self.currentWriterDetail?.karya[indexPath.row].cover_url)!, for: cell.karyaImageView)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedBookId = currentWriterDetail?.karya[indexPath.row].id as! Int
        performSegue(withIdentifier: "ToBookDetail", sender: nil)
    }
    
    
}
