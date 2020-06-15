//
//  ViewController.swift
//  Buku-Ku
//
//  Created by Randy Efan Jayaputra on 15/06/20.
//  Copyright © 2020 Randy Efan Jayaputra. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var picker: UIPickerView!
    
    let apiKeyImage = "&api_key=32ded42cfffb77dee86a29f43d36a3641849d4b5904aade9a79e9aa6cd5b5948"
    
    let decoder = JSONDecoder()
    var books = [Buku]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
            let api = "https://cabaca.id:8443/api/v2/book/category?id=1"
            self.decode(api: api)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainToDetail" {
            if let index = sender as? IndexPath {
                let dvc = segue.destination as! DetailBukuViewController
                dvc.id = books[index.row].id
            }
            
        }
    }
    
    func decode(api: String) {
        ApiConnector.request(api, method: .get, successDataAction: { (data) in
                do {
                    let buku = try self.decoder.decode(Respone.self, from: data)
                    DispatchQueue.main.async {
                        self.books = buku.result
                        self.collectionView.reloadData()
                    }
                } catch let jsonErr {
                    print("Fail to decode json", jsonErr)
                }
            })
        }
    
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return configureCollectionCell(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "mainToDetail", sender: indexPath)
    }
    
    
}

extension ViewController {
    func configureCollectionCell(at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BukuCell", for: indexPath) as! BukuCollectionViewCell
        
        let imgUrl = URL(string:"https://cabaca.id:8443/api/v2/files/" + (self.books[indexPath.row].cover as! String) + apiKeyImage)
        
        cell.imageBuku.sd_setImage(with: imgUrl, completed: nil)
        cell.titleBuku.text = self.books[indexPath.row].title
        return cell
    }
}
