//
//  ViewController.swift
//  projectJA
//
//  Created by vind-opisk on 05/10/2017.
//  Copyright © 2017 vind-opisk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var button2_to_change_view : UIButton!
    var button_to_change_view : UIButton!
    var button_demo_button : UIButton!
    
    
    let another_view_controller = AnotherViewController()
    let button_demo_view_controller = ButtonDemoViewController()
    let another_one_view_controller = AnotherOneViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        set_up_view()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func change_button_pressed()
    {
        
        button_demo_view_controller.modalTransitionStyle = .coverVertical
        button_demo_view_controller.modalPresentationStyle = .formSheet
        
        present( button_demo_view_controller, animated: true, completion: nil )
    }
    
    func change_button_pressed_second()
    {
        
        another_view_controller.modalTransitionStyle = .coverVertical
        another_view_controller.modalPresentationStyle = .formSheet
        
        present( another_view_controller, animated: true, completion: nil )
    }
    
    
    func change_button_pressed_third()
    {
        
        another_one_view_controller.modalTransitionStyle = .coverVertical
        another_one_view_controller.modalPresentationStyle = .formSheet
        
        present( another_one_view_controller, animated: true, completion: nil )
    }
    
    func set_up_view() {
    
    button_demo_button = UIButton( type: .system )
    
    button_demo_button.setTitle( "Game 1", for: .normal )
    
    button_demo_button.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 24 )
    
    button_demo_button.translatesAutoresizingMaskIntoConstraints = false
    
    button_demo_button.layer.cornerRadius = 10 // This rounds the corners
    button_demo_button.clipsToBounds = true    // This is needed as well
    
    
    button_demo_button.backgroundColor = UIColor.yellow
    button_demo_button.setTitleColor( UIColor.purple, for: .normal )
    
    button_demo_button.addTarget( nil, action: #selector( change_button_pressed ),
    for: .touchUpInside )
    
    button_demo_button.widthAnchor.constraint( equalToConstant: 192 ).isActive = true
    button_demo_button.heightAnchor.constraint( equalToConstant: 96 ).isActive = true
    
    view.addSubview( button_demo_button )
    
    button_demo_button.centerXAnchor.constraint(
    equalTo: view.layoutMarginsGuide.centerXAnchor ).isActive = true
    button_demo_button.centerYAnchor.constraint(
    equalTo: view.layoutMarginsGuide.topAnchor,constant: 100 ).isActive = true
    
    button_to_change_view = UIButton( type: .system )
    
    button_to_change_view.setTitle( "Game 2", for: .normal )
    
    button_to_change_view.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 24 )
    
    button_to_change_view.translatesAutoresizingMaskIntoConstraints = false
    
    button_to_change_view.layer.cornerRadius = 10 // This rounds the corners
    button_to_change_view.clipsToBounds = true    // This is needed as well
    
    
    button_to_change_view.backgroundColor = UIColor.green
    button_to_change_view.setTitleColor( UIColor.purple, for: .normal )
    
    button_to_change_view.addTarget( nil, action: #selector( change_button_pressed_second ),
                                                            for: .touchUpInside )
    
    button_to_change_view.widthAnchor.constraint( equalToConstant: 192 ).isActive = true
    button_to_change_view.heightAnchor.constraint( equalToConstant: 96 ).isActive = true
    
    view.addSubview( button_to_change_view )
    
    button_to_change_view.centerXAnchor.constraint(
        equalTo: view.layoutMarginsGuide.centerXAnchor ).isActive = true
    button_to_change_view.centerYAnchor.constraint(
        equalTo: view.layoutMarginsGuide.centerYAnchor,constant: 0 ).isActive = true
        
    
    button2_to_change_view = UIButton( type: .system )
    
    button2_to_change_view.setTitle( "Game 3", for: .normal )
    
    button2_to_change_view.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 24 )
    
    button2_to_change_view.translatesAutoresizingMaskIntoConstraints = false
    
    button2_to_change_view.layer.cornerRadius = 10 // This rounds the corners
    button2_to_change_view.clipsToBounds = true    // This is needed as well
    
    
    button2_to_change_view.backgroundColor = UIColor.red
    button2_to_change_view.setTitleColor( UIColor.purple, for: .normal )
    
    button2_to_change_view.addTarget( nil, action: #selector(change_button_pressed_third ),
                                     for: .touchUpInside )
    
    button2_to_change_view.widthAnchor.constraint( equalToConstant: 192 ).isActive = true
    button2_to_change_view.heightAnchor.constraint( equalToConstant: 96 ).isActive = true
    
    view.addSubview( button2_to_change_view )
    
    button2_to_change_view.centerXAnchor.constraint(
        equalTo: view.layoutMarginsGuide.centerXAnchor ).isActive = true
    button2_to_change_view.centerYAnchor.constraint(
        equalTo: view.layoutMarginsGuide.centerYAnchor,constant: 250 ).isActive = true
    

        
    }

}

