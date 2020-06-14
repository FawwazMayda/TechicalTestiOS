//
//  NetReq.swift
//  TechnicalTest
//
//  Created by Muhammad Fawwaz Mayda on 14/06/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import Foundation

class NetReq {
    
    var delegate: NetReqDelegate?
    let session : URLSession
    init(){
        session = URLSession.shared
    }
    
    func reqGenre() {
        let url = "https://cabaca.id:8443/api/v2/cabaca/_table/genre"
        var returnData = [Genre]()
        var requests = URLRequest(url: URL(string: url)!)
        requests.setValue("25e0bf00ab2fa7f03a9fa57035139e47ccb28c20658f6de907b8011347e369fb", forHTTPHeaderField: "x-dreamfactory-api-key")
        let task = session.dataTask(with: requests) { (data, response, error) in
            if let currentData = data {
                returnData = self.parseGenre(data: currentData)
                self.delegate?.didGetGenre(data: returnData)
            }
        }
        task.resume()
    }
    
    func parseGenre(data: Data) -> [Genre]{
        let decoder = JSONDecoder()
        do {
            let genreData = try! decoder.decode(GenreParse.self, from: data)
            print(genreData.resource[0].title)
            return genreData.resource
        } catch {
            print(error)
        }
    }
    
    func reqBookByGenre(genre_id: Int){
        let url = "https://cabaca.id:8443/api/v2/book/category?id=\(genre_id)"
        var requests = URLRequest(url: URL(string: url)!)
        requests.setValue("25e0bf00ab2fa7f03a9fa57035139e47ccb28c20658f6de907b8011347e369fb", forHTTPHeaderField: "x-dreamfactory-api-key")
        let task = session.dataTask(with: requests) { (data, response, error) in
            if let currentData = data {
                self.parseBookByGenre(data: currentData)
            }
        }
        task.resume()
    }
    
    func parseBookByGenre(data: Data){
        let decoder = JSONDecoder()
        do {
            let bookData =  try! decoder.decode(BookParse.self, from: data)
            print(bookData.result[0].Writer_by_writer_id.status)
            print(bookData.result[0].Writer_by_writer_id.User_by_user_id.name)
        } catch {
            print(error)
        }
    }
    
    func reqBookByDetail(book_id: Int){
        let url = "https://cabaca.id:8443/api/v2/book/detail/\(book_id)"
        var requests = URLRequest(url: URL(string: url)!)
        requests.setValue("25e0bf00ab2fa7f03a9fa57035139e47ccb28c20658f6de907b8011347e369fb", forHTTPHeaderField: "x-dreamfactory-api-key")
        let task = session.dataTask(with: requests) { (data, response, error) in
            if let currentData = data {
                self.parseBookDetail(data: currentData)
            }
        }
        task.resume()
    }
    
    func parseBookDetail(data: Data) {
        do {
            let bookDetailData = try! JSONDecoder().decode(BookDetailParse.self, from: data)
            print(bookDetailData.result.title)
        } catch {
            print(error)
        }
    }
    //MARK: -Book Update
    func reqBookUpdate(limit: Int) {
        let url = "https://cabaca.id:8443/api/v2/book/uptodate?limit=\(limit)"
               var requests = URLRequest(url: URL(string: url)!)
               requests.setValue("25e0bf00ab2fa7f03a9fa57035139e47ccb28c20658f6de907b8011347e369fb", forHTTPHeaderField: "x-dreamfactory-api-key")
               let task = session.dataTask(with: requests) { (data, response, error) in
                   if let currentData = data {
                    self.delegate?.didGetBookUpdate(data: self.parseBookUpdate(data: currentData))
                   }
               }
               task.resume()
    }
    
    func parseBookUpdate(data: Data)-> [BookUpdate] {
        do {
            let bookUpdateData = try! JSONDecoder().decode(BookUpdateParse.self, from: data)
            print(bookUpdateData.result[0].title)
            return bookUpdateData.result
        } catch {
            print(error)
        }
    }
    
    
    
    //MARK: - Writer Detail
    
    func reqWriterDetail(writer_id: Int) {
        let url = "https://cabaca.id:8443/api/v2/writer/detail/\(writer_id)"
        var requests = URLRequest(url: URL(string: url)!)
                      requests.setValue("25e0bf00ab2fa7f03a9fa57035139e47ccb28c20658f6de907b8011347e369fb", forHTTPHeaderField: "x-dreamfactory-api-key")
                      let task = session.dataTask(with: requests) { (data, response, error) in
                          if let currentData = data {
                           self.parseWriterDetail(data: currentData)
                          }
                      }
                      task.resume()
    }
    
    func parseWriterDetail(data: Data) {
        do {
            let writerDetailData = try! JSONDecoder().decode(WriterDetailParse.self, from: data)
            print(writerDetailData.result.karya[0].title)
        } catch {
            print(error)
        }
    }
}
