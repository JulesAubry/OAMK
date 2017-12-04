//
//  AnotherOneViewController.swift Copyright Jules AUBRY
//  projectJA
//
//  2017-10-4 Created by Jules.
//  Copyright © 2017 Jules. All rights reserved.

import UIKit

class AnotherOneViewController: UIViewController
{
   override func didReceiveMemoryWarning()
   {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

   override func loadView()
   {
      view = AnotherOneView( frame: UIScreen.main.bounds )
    
      self.view.backgroundColor = UIColor.white
    
     ( view as! AnotherOneView ).launch_game()
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
        self.navigationController?.popToRootViewController(animated: true)
        
        
    }
    
}

