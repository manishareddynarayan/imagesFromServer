//
//  ViewController.swift
//  imagesFromServer
//
//  Created by N Manisha Reddy on 2/12/18.
//  Copyright © 2018 N Manisha Reddy. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    var images: [Details]? = []
    override func viewDidLoad() {
        super.viewDidLoad()
          getImages()
    }
    func getImages() {
        let urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=a598028d60a444f1ad150840a6e58de1")!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                print(error)
                return
            }
            self.images = [Details]()
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                if let imagesFromJson = json["articles"] as? [[String : Any]] {
                    for imageFromJson in imagesFromJson {
                        let img = Details()
                        if let url = imageFromJson["url"] as? String,let urlToImage = imageFromJson["urlToImage"] as? String {
                            img.url = url
                            img.imageUrl = urlToImage
                        }
                        self.images?.append(img)
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print(error)
            }
            
        }
        task.resume()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! ImageTableCell
        cell.imgView?.downloadImage(from: (self.images?[indexPath.item].imageUrl!)!)
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.images?.count)!
    }
}
extension UIImageView {
    func downloadImage(from url: String) {
        let urlRequest = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: urlRequest as URLRequest) { (data, response, error) in
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
                
            }
        }
        task.resume()
    
    }
    
    
}

