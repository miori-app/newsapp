//
//  ViewController.swift
//  mioriTable
//
//  Created by miori Lee on 2020/07/15.
//  Copyright © 2020 miori. All rights reserved.
//


import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableViewMain: UITableView!
    
    var newsData : Array<Dictionary<String, Any>>?
    //? : optional 값이 비어있을수 있다.
    
    /*
     * http 통신방법 - urlsession (네트워크 통신)
     * json 데이터형태 (key,value) (JSONSerialization 에서 json은 dict형태로 친자확인)
     * 값보여주는 거는 main thread
     * tableView 의  data matching 그리고 뿌리기(통보!!)
     */
    func getNews(){
        let task = URLSession.shared.dataTask(with: URL(string: "your api")!) { (data, response, error) in
            // input yout api in "your api" 
            if let dataJson = data{
                //print(dataJson)
                
                //json parsing
                
                do{
                    let json = try JSONSerialization.jsonObject(with: dataJson, options: []) as! Dictionary<String, Any>
                    //print(json)
                    let articles = json["articles"] as! Array<Dictionary<String, Any>>
                    //print(articles)
                    self.newsData = articles
                    
                    
                    // 모바일 네트워크 통신시 백그라운드에서 돌아
                    /*
                     -  이때 동작하는 애가 thread.
                     - ui그리는 거는 Main
                     */
                    DispatchQueue.main.async{
                        self.tableViewMain.reloadData() //화면은 위에서 그려야함
                    }
                    //do 안에 들어가서 self로 바꿔서 viewController밖에 있는 애임을 알려줌
                    
                    //json은 dict형태
                    //일단 인코딩 안되어있음.
                    //                    for (idx, value) in articles.enumerated() {
                    //                        if let v = value as? Dictionary<String, Any>{
                    //                            print("\(v["title"])")
                    //                            v["description"]
                    //                        }
                    //                    }
                }catch{
                    
                }
            }
        }
        
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //data 몇개
        
        if let news = newsData{
            return news.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //data 무엇
        
        //임의의 셀 만들기 (방법1)
        //let cell = UITableViewCell.init(style: .default, reuseIdentifier: "TableCellType1")
        let cell = tableViewMain.dequeueReusableCell(withIdentifier: "Type1" , for: indexPath) as! Type1
        //반환형이 UITableViewCell
        /*
         as 친자확인 용도
         as? 나 맞아?
         as! 나 맞아!
         */
        
        let idx = indexPath.row
        
        //newsData가 비어있지 않다면
        if let news = newsData{
            //idexPath의 row를 갖고와서
            let row = news[idx]
            if let r = row as? Dictionary<String, Any>{
                //정보가 dict형태라면
                if let title = r["title"] as? String{ //바인딩
                    cell.myText.text = "\(title)"
                }
            }
            
            
            //cell.textLabel?.text = "\(indexPath.row)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableViewMain.delegate = self
        tableViewMain.dataSource = self
        
        //self의 의미 : class 안에 function들
        getNews()
    }
}


//tableView 여러개의 행이 모여있음
/*
 1. 데이터 무엇인지
 2. 몇개인지
 3. click event
 */
