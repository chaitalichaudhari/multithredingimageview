//
//  FirstViewController.swift
//  multithredingimageview
//
//  Created by Felix ITs 03 on 02/01/19.
//  Copyright © 2019 chaitali. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return urlArray.count
//    }
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
//        cell.imageview?.image = UIImage(named: String(urlArray[indexPath.row]))
//       let session = URLSession(configuration: .default)
//        let dataTask = session.dataTask(with: urlArray){
//            (data,response,error) in
//            if(data != nil)
//            {
//                let image = UIImage(data: data!)
//                DispatchQueue.main.async {
//                    self.imageview.image=image
//                }
//            }
//
//        }
//        dataTask.resume()
//
//        return cell
//    }
    
    var urlArray=[String]()
    enum JSONError:String,Error
    {
        case NOResponse = "Error:No Response"
        case NOData = "Error:No Data"
        case convenstionFailed = "Error:Conversion from Json Failed"
    }
    func jsonParser(url1:String)
    {
        guard let endPoint=URL(string: url1)
            else
        {
                print("Error in creating endPoint")
                return
        }
        URLSession.shared.dataTask(with: endPoint)
        {(data,response,error) in
            do{
                guard let response=response
                    else{
                        throw JSONError.NOResponse
                }
                print(response)
                guard let data = data else
                {
                    throw JSONError.NOData
                }
                guard let jsonFirstArray:[[String:Any]] = try JSONSerialization.jsonObject(with: data, options: [])as? [[String:Any]]
                    else
                {
                        throw JSONError.convenstionFailed
                        
                }
                print(jsonFirstArray)
                for dic in jsonFirstArray
                {
        
                let authorDic:[String:Any] = dic["author"] as! [String:Any]
                let urlStr = authorDic["avatar_url"] as! String
                self.urlArray.append(urlStr)
                
                }
                print(self.urlArray)
                DispatchQueue.main.async {
                    self.tableview1.reloadData()
                }
                
            }
            catch let error as JSONError
            {
                print(error.rawValue)
            }
            catch let error as NSError
            {
                print(error.debugDescription)
            }
            
            }
       .resume()
    }
    @IBOutlet weak var tableview1: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonParser(url1: "http://api.github.com/repositories/19438/commits")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

