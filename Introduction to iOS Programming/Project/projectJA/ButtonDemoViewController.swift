//
//  ButtonDemoViewController.swift Copyright Jules AUBRY
//  projectJA
//
//  2017-10-4 Created by Jules.
//  Copyright © 2017 Jules. All rights reserved.

import UIKit

class ButtonDemoViewController: UIViewController,UIGestureRecognizerDelegate
{
   override func didReceiveMemoryWarning()
   {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ButtonDemoViewController.handleTap(gestureRecognizer:)))
        gestureRecognizer.delegate = self
        view.addGestureRecognizer(gestureRecognizer)
        ( view as! ButtonDemoView ).launch_game()
    }

   override func loadView()
   {
      view = ButtonDemoView( frame: UIScreen.main.bounds )
   }
    
    func button_pressed()
    {
        loadView()
        refreshView()
        presentingViewController!.dismiss( animated: true )
    }
    
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        ( view as! ButtonDemoView ).is_inside(gestureRecognizer)
    }
    
    func refreshView() {
        
        // Calling the viewDidLoad and viewWillAppear methods to "refresh" the VC and run through the code within the methods themselves
        self.viewDidLoad()
        
    }
}

