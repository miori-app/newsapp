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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //data 몇개
        return 100
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
        cell.myText.text = "\(indexPath.row)"
        
        
        //cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableViewMain.delegate = self
        tableViewMain.dataSource = self
        
        //self의 의미 : class 안에 function들
    }
    
    //tableView 여러개의 행이 모여있음
    /*
     1. 데이터 무엇인지
     2. 몇개인지
     3. click event
     */


}

