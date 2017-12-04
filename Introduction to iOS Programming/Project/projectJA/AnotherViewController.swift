//
//  AnotherViewController.swift Copyright Jules AUBRY
//  projectJA
//
//  2017-10-4 Created by Jules.
//  Copyright © 2017 Jules. All rights reserved.

import UIKit

class AnotherViewController: UIViewController
{
   override func didReceiveMemoryWarning()
   {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.green
    }

   override func loadView()
   {
      view = AnotherButtonView( frame: UIScreen.main.bounds )
   }
    
    func button_pressed()
    {
        loadView()
        refreshView()
        presentingViewController!.dismiss( animated: true )
    }
    
    func refreshView() {
        
        // Calling the viewDidLoad and viewWillAppear methods to "refresh" the VC and run through the code within the methods themselves
        self.viewDidLoad()
        
    }
    
}

