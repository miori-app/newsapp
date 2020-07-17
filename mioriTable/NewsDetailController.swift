//
//  newsDetailController.swift
//  mioriTable
//
//  Created by miori Lee on 2020/07/16.
//  Copyright © 2020 miori. All rights reserved.
//

import UIKit

class NewsDetailController : UIViewController{
    
    @IBOutlet weak var imageMain: UIImageView!
    @IBOutlet weak var textViewMain: UITextView!
    //1. json의 이미지 url
    //2. json의 description
    
    var imageUrl : String?
    var desc : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //값이 있으면
        if let img = imageUrl{
            //이미지 가져와서 뿌려
            //Data
            if let data = try? Data(contentsOf: URL(string: img)!){
                
                //UI가 바뀌는 건 main 에서 해줘야함
                DispatchQueue.main.async {
                    self.imageMain.image = UIImage(data: data)
                }
            }
            
        }
        
        if let de = desc{
            //본문 가져와서 뿌려
            self.textViewMain.text = de
        }
    }
}

