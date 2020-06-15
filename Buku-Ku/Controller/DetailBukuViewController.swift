//
//  DetailBukuViewController.swift
//  Buku-Ku
//
//  Created by Randy Efan Jayaputra on 15/06/20.
//  Copyright © 2020 Randy Efan Jayaputra. All rights reserved.
//

import UIKit
import SDWebImage

class DetailBukuViewController: UIViewController {
    @IBOutlet weak var imageBook: UIImageView!
    @IBOutlet weak var judulBukuLabel: UILabel!
    @IBOutlet weak var penulisLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    let apiKeyImage = "&api_key=32ded42cfffb77dee86a29f43d36a3641849d4b5904aade9a79e9aa6cd5b5948"
    
    var id: Int?
    
    let decoder = JSONDecoder()
    var books = [Buku]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard id != nil else {
            return
        }

        let api = "https://cabaca.id:8443/api/v2/book/detail/\(id!)"
        print(api)
        
        decode(api: api)
    }
    
    func decode(api: String) {
    ApiConnector.request(api, method: .get, successDataAction: { (data) in
            do {
                let buku = try self.decoder.decode(Respon.self, from: data)
                DispatchQueue.main.async {
                    self.judulBukuLabel.text = buku.result.title
                    self.penulisLabel.text = buku.result.writer.user.nama
                    self.synopsisLabel.text = buku.result.desc
                    let imgUrl = URL(string:"https://cabaca.id:8443/api/v2/files/" + (buku.result.cover as! String) + self.apiKeyImage)
                    
                    self.imageBook.sd_setImage(with: imgUrl, completed: nil)
                    
                }
            } catch let jsonErr {
                print("Fail to decode json", jsonErr)
            }
        })
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
