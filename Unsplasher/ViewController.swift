//
//  ViewController.swift
//  Unsplasher
//
//  Created by David on 2018/3/8.
//  Copyright © 2018年 David. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    GetPhotos().perform(page: 1)
      .then(execute: { data in
        print("\n", data)
      })
      .catch(execute: { e in
        print(e)
      })
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

