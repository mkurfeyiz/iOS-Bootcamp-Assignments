//
//  ViewController.swift
//  api_ornek
//
//  Created by mkurfeyiz on 2.02.2022.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var cvCategories: UICollectionView!
    
    var loginResponse: CResponse!
    var categoryResponse: CategoryResponse!
    var categoryList = [CategoryData]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loginRequest()
    }
    
    func loginRequest() {
        var loginRequest = URLRequest(url: ConstantApis.loginUrl!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        var header = [String : String]()
        header["Content-Type"] = "application/json"
        loginRequest.allHTTPHeaderFields = header
        
        loginRequest.httpMethod = "post"
        
        let params: [String : Any] = [
            "Phone" : "123456789",
            "Password" : "password"
        ]
        
        loginRequest.httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
        
        URLSession.shared.dataTask(with: loginRequest) { data, response, error in
            if error != nil {
                //Alert
                self.alert()
            } else {
                do {
                    let loginRes = response as! HTTPURLResponse
                    
                    if loginRes.statusCode == 200 && data != nil {
                        //To check the values first
                        //let json = try JSON(data: data!)
                        if self.loginResponse == nil {
                            self.loginResponse = CResponse()
                        }
                        
                        self.loginResponse = try JSONDecoder().decode(CResponse.self, from: data!)
                        self.categoryRequest(token: self.loginResponse.data.token!)
                        
                        //print(json)
                    }
                } catch {
                    
                }
            }
        }.resume()
    }
    
    func categoryRequest(token: String) {
        var categoryRequest = URLRequest(url: ConstantApis.categoryUrl!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        var header = [String : String]()
        header["Authorization"] = "Bearer \(token)"
        
        categoryRequest.allHTTPHeaderFields = header
        
        //Default Value = GET
        //categoryRequest.httpMethod = "get"
        
        URLSession.shared.dataTask(with: categoryRequest) { data, response, error in
            if error != nil {
                //Alert
                self.alert()
            } else {
                do {
                    let categoryRes = response as! HTTPURLResponse
                    
                    if categoryRes.statusCode == 200 && data != nil {
                        if self.categoryResponse == nil {
                            self.categoryResponse = CategoryResponse()
                        }
                        
                        //let json = try JSON(data: data!)
                        
                        self.categoryResponse = try JSONDecoder().decode(CategoryResponse.self, from: data!)
                        
                        self.categoryList = self.categoryResponse.data
                        //Needed a loop for setting image urls for every category
                        /*for item in self.categoryResponse.data {
                            //No need to set every categories image url in here. We will be doing it in
                            //collectionView cellForItemAt
                            self.categoryList.append(item)
                        }*/
                        
                        DispatchQueue.main.async {
                            self.setLayout()
                            self.cvCategories.register(UINib(nibName: "CVC_Category", bundle: nil), forCellWithReuseIdentifier: "CVC_Category")
                            //Need to reload CollectionView
                            self.cvCategories.reloadData()
                        }
                        
                        //print(json)
                    }
                } catch {
                    
                }
            }
        }.resume()
        
    }
    
    func setLayout() {
        let layout = cvCategories.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                
        let cvWidth = (cvCategories.frame.size.width - 25.0) / 3.0
        let cvHeight = cvWidth
        layout?.itemSize = CGSize(width: cvWidth, height: cvHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = categoryList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVC_Category", for: indexPath) as! CVC_Category
        
        category.imageUrl = "\(ConstantApis.baseImageUrl!)\(category.imageUrl ?? "")"
        let imageData = try? Data(contentsOf: URL(string: category.imageUrl)!)
        cell.ivImage.image = UIImage(data: imageData!)
        cell.lblTitle.text = category.name
        cell.layer.borderWidth = 1
        
        return cell
    }
    
    func alert() {
        let ac = UIAlertController(title: nil, message: "An error has occured.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        present(ac, animated: true, completion: nil)
    }


}

