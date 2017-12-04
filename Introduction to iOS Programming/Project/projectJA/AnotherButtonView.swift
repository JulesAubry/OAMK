//
//  AnotherButtonView.swift Copyright Jules AUBRY
//  projectJA
//
//  2017-10-4 Created by Jules.
//  Copyright © 2017 Jules. All rights reserved.

/* This version of the ButtonDemo app is created without the Interface
   Builder.
 
   When the project was created:
     Main.storyboard was deleted
     Main interface field was emptied.
 
   As the Interface Builder is not in use, all characteristics
   of the UILabel and UIButton are specified here with Swift code.
 
   Constraints are specified to position these UI components.
 
*/



import UIKit


class AnotherButtonView: UIView
{
    let stoneButton1  = UIButton(type: .custom)
    let stoneButton2  = UIButton(type: .custom)

    let paperButton1  = UIButton(type: .custom)
    let paperButton2  = UIButton(type: .custom)

    let scissorsButton1  = UIButton(type: .custom)
    let scissorsButton2  = UIButton(type: .custom)

    let button_to_press: UIButton
    
    
    let showRes : UILabel
    
   
   override init( frame: CGRect )
   {
    showRes = UILabel()
    showRes.translatesAutoresizingMaskIntoConstraints = false
    showRes.textAlignment = .center
    showRes.text = "Result here"
    showRes.font = UIFont( name: "Georgia", size: 25 )
    showRes.textColor = UIColor.yellow
    
    button_to_press = UIButton(type: .system)
    button_to_press.translatesAutoresizingMaskIntoConstraints = false
    button_to_press.setTitle("Go back to menu", for: .normal)
    
    button_to_press.backgroundColor = UIColor.red
    button_to_press.setTitleColor( UIColor.white, for: .normal )
    button_to_press.layer.cornerRadius = 5
    button_to_press.layer.borderWidth = 2
    button_to_press.layer.borderColor = UIColor.black.cgColor
    
    button_to_press.addTarget( nil, action: #selector( AnotherViewController.button_pressed ),
                               for: .touchUpInside )
    
    let image1 = UIImage(named: "Images/stone.jpg") as UIImage!
    let image2 = UIImage(named: "Images/paper.jpg") as UIImage!
    let image3 = UIImage(named: "Images/scissors.jpg") as UIImage!
    
    stoneButton1.frame = CGRect(x: 25, y: 25, width: 150, height: 150)
    stoneButton1.setImage(image1, for: .normal)
    stoneButton1.contentMode = .center
    stoneButton1.imageView?.contentMode = .scaleToFill
    stoneButton2.frame = CGRect(x: 25, y: 300, width: 150, height: 150)
    stoneButton2.setImage(image1, for: .normal)
    stoneButton2.contentMode = .center
    stoneButton2.imageView?.contentMode = .scaleToFill
    
    paperButton1.frame = CGRect(x: 175, y: 25, width: 150, height: 150)
    paperButton1.setImage(image2, for: .normal)
    paperButton1.contentMode = .center
    paperButton1.imageView?.contentMode = .scaleToFill
    paperButton2.frame = CGRect(x: 175, y: 300, width: 150, height: 150)
    paperButton2.setImage(image2, for: .normal)
    paperButton2.contentMode = .center
    paperButton2.imageView?.contentMode = .scaleToFill
    
    scissorsButton1.frame = CGRect(x: 100, y: 175, width: 150, height: 80)
    scissorsButton1.setImage(image3, for: .normal)
    scissorsButton1.contentMode = .center
    scissorsButton1.imageView?.contentMode = .scaleToFill
    scissorsButton2.frame = CGRect(x: 100, y: 450, width: 150, height: 80)
    scissorsButton2.setImage(image3, for: .normal)
    scissorsButton2.contentMode = .center
    scissorsButton2.imageView?.contentMode = .scaleToFill
    
    stoneButton2.isEnabled = false
    paperButton2.isEnabled = false
    scissorsButton2.isEnabled = false
    
   
    super.init(frame : frame)
   
    stoneButton1.addTarget(self, action: #selector(AnotherButtonView.buttonClicked(_:)), for: .touchUpInside)
    paperButton1.addTarget(self, action: #selector(AnotherButtonView.buttonClicked(_:)), for: .touchUpInside)
    scissorsButton1.addTarget(self, action: #selector(AnotherButtonView.buttonClicked(_:)), for: .touchUpInside)
    
    addSubview(showRes)
    addSubview(stoneButton1)
    addSubview(stoneButton2)
    addSubview(paperButton1)
    addSubview(paperButton2)
    addSubview(scissorsButton1)
    addSubview(scissorsButton2)
    addSubview(button_to_press)
    
    showRes.topAnchor.constraint( equalTo: layoutMarginsGuide.topAnchor,
                                       constant: 265 ).isActive = true
    
    // The following two statements specify that the label is centered horizontally.
    
    showRes.leadingAnchor.constraint( equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
    showRes.trailingAnchor.constraint( equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
    
    button_to_press.widthAnchor.constraint( equalToConstant: 200 ).isActive = true
    button_to_press.heightAnchor.constraint( equalToConstant: 64 ).isActive = true
    
    
    
    // Button in centered horizontally as the label.
    button_to_press.centerXAnchor.constraint( equalTo: centerXAnchor ).isActive = true
    
    // The button will be 64 pixels below the label.
    button_to_press.topAnchor.constraint( equalTo: centerYAnchor,
                                          constant: 250 ).isActive = true
    
    
   }
    
   
   convenience required init(coder aDecoder: NSCoder)
   {
      self.init()
   }
    
    func buttonClicked(_ sender: AnyObject?) {
        removeAllBorders()
        
        let rand = int_fast32_t(arc4random_uniform(3)+1)
        var result : int_fast32_t
        result = 0
        
        addBorderRand(random:rand)
        
        if sender === stoneButton1 {
            stoneButton1.layer.cornerRadius = 5
            stoneButton1.layer.borderWidth = 2
            stoneButton1.layer.borderColor = UIColor.black.cgColor
            
            result = winner(player1:1,player2:rand)
        } else if sender === paperButton1 {
            paperButton1.layer.cornerRadius = 5
            paperButton1.layer.borderWidth = 2
            paperButton1.layer.borderColor = UIColor.black.cgColor
            
            result = winner(player1:2,player2:rand)
        } else if sender === scissorsButton1 {
            scissorsButton1.layer.cornerRadius = 5
            scissorsButton1.layer.borderWidth = 2
            scissorsButton1.layer.borderColor = UIColor.black.cgColor
            
            result = winner(player1:3,player2:rand)
        }
        
        print_result(res: result)
    }
    
    func winner(player1: int_fast32_t, player2 : int_fast32_t) -> int_fast32_t{
        switch player1 {
        case 1:
            if(player2 == 1) {return 0}
                else if(player2 == 2) {return -1}
            else {return 1}
        case 2:
                    if(player2 == 1){ return 1}
                        else if(player2 == 2){ return 0}
                    else{ return -1}
        case 3:
                            if(player2 == 1) {return -1}
                                else if(player2 == 2){ return 1}
                            else {return 0}
        default:
            break
        }
        return -2
    }
    
    func print_result(res : int_fast32_t) {
        switch res {
        case 0:
            showRes.text = "DRAW !"
        case 1:
            showRes.text = "WON !"
        case -1:
            showRes.text = "LOST !"
        default:
            break
        }
    }
    
    func removeAllBorders(){
        stoneButton1.layer.borderWidth = 0
        paperButton1.layer.borderWidth = 0
        scissorsButton1.layer.borderWidth = 0
        stoneButton2.layer.borderWidth = 0
        paperButton2.layer.borderWidth = 0
        scissorsButton2.layer.borderWidth = 0
    }
    
    func addBorderRand(random : int_fast32_t) {
        switch random {
        case 1:
            stoneButton2.layer.cornerRadius = 5
            stoneButton2.layer.borderWidth = 2
            stoneButton2.layer.borderColor = UIColor.black.cgColor
        case 2:
            paperButton2.layer.cornerRadius = 5
            paperButton2.layer.borderWidth = 2
            paperButton2.layer.borderColor = UIColor.black.cgColor
        case 3:
            scissorsButton2.layer.cornerRadius = 5
            scissorsButton2.layer.borderWidth = 2
            scissorsButton2.layer.borderColor = UIColor.black.cgColor
        default:
            break
        }
    }
}

