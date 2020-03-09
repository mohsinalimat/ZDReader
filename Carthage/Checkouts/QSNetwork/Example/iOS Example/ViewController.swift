//
//  ViewController.swift
//  iOS Example
//
//  Created by Nory Cao on 16/12/26.
//  Copyright © 2016年 masterY. All rights reserved.
//

import UIKit
import QSNetwork

class ViewController: UIViewController {

    var imageView:UIImageView?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "QSNetwork"
        view.addSubview(self.body)
        let leftItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(request))
        self.navigationItem.leftBarButtonItem = leftItem
        
        let rightItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(push))
        self.navigationItem.rightBarButtonItem = rightItem
        
        imageView = UIImageView(frame: CGRect(x: self.view.bounds.width/2 - 50, y: self.view.bounds.height/2 - 50, width: 100, height: 100))
        imageView?.backgroundColor = UIColor.orange
        view.addSubview(imageView!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        internet()
        
    }
    
    @IBAction func request(_ sender: Any) {
        let url = URL(string: "http://www.example.com/index.php?key1=value1&key2=value2")
        let urlComponents = URLComponents(url: url!, resolvingAgainstBaseURL: false)
        let percentEncodedQuery = (urlComponents?.percentEncodedQuery.map { $0  } ?? "")
        print(percentEncodedQuery)

    }
    
    @IBAction func push(_ sender: Any) {
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.white
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @discardableResult
    func internet()->String{
        _ = ["leftTicketDTO.train_date":"2017-01-25","leftTicketDTO.from_station":"BJP","leftTicketDTO.to_station":"SHH","purpose_codes":"ADULT"]
        //12306的参数不能错位，否则无法请求到数据
        let defaultUrl = "https://kyfw.12306.cn/otn/leftTicket/queryA?leftTicketDTO.train_date=2017-01-06&leftTicketDTO.from_station=BJP&leftTicketDTO.to_station=SHH&purpose_codes=ADULT"
        QSNetwork.setDefaultURL(url: defaultUrl)
        let result =  QSNetwork.request("", method: .get, parameters: nil, headers: nil,completionHandler: nil)
        do{
            print(result.error as? NSError ?? "" )
            try print(JSONSerialization.jsonObject(with: result.data ?? Data(), options: .allowFragments))
        }catch{
            
        }
        return "nimei"
    }
    
    func downloadImage(){
        QSNetwork.download("http://168.3.62.218:7044/Loading.jpg") { (url, response, error) in
            print(response)
            print(url)
            let cachesPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first?.appending( "/\(response?.suggestedFilename ?? "")")
            do{
                try FileManager.default.moveItem(at: url!, to: URL.init(fileURLWithPath: cachesPath ?? ""))
                self.imageView?.image = UIImage(contentsOfFile: cachesPath ?? "")
            }catch{

            }
        }
    }
    
    func update(text:String){
        self.body.text = text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private lazy var body:UITextView = {
       let body = UITextView()
        body.frame = self.view.bounds
        body.text = ""
        body.font = UIFont.systemFont(ofSize: 11)
        body.textColor = UIColor.red
        body.isEditable = false
        return body
    }()
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    var bodyText:String = ""
}


