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
    var selectedBookId = 0
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        ng.delegate = self
        ng.reqBookUpdate(limit: 7)
        // Do any additional setup after loading the view.
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToBookDetail" {
            let destVC = segue.destination as? BookDetailViewController
            destVC?.book_id = selectedBookId
        }
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookUpdateCell", for: indexPath) as? UpdateBookViewCell else { fatalError("No custom cell") }
        cell.updateBookLabel.text = updateData[indexPath.row].title
        getImageFromUrl(forCoverURL: updateData[indexPath.row].cover_url, for: cell.updateBookImageView)
        //cell.textLabel?.text = updateData[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedBookId = updateData[indexPath.row].id
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ToBookDetail", sender: nil)
    }
    
    
}

