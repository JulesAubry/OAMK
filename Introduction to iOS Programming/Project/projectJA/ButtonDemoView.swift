//
//  ButtonDemoView.swift Copyright Jules AUBRY
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


class ButtonDemoView: UIView
{
   let text_to_show: UILabel
    let time: UILabel
   let button_to_press: UIButton
    var ball : Ball
    var timer : Timer
    var valueTimer : int_fast32_t
    var hits : int_fast32_t
    var hit : Bool
    var seconds : int_fast32_t

   
   override init( frame: CGRect )
   {
      text_to_show = UILabel()
      text_to_show.translatesAutoresizingMaskIntoConstraints = false
      text_to_show.textAlignment = .center
      text_to_show.text = "Click on the circles !"
      text_to_show.font = UIFont( name: "Georgia", size: 36 )
    
    time = UILabel()
    time.translatesAutoresizingMaskIntoConstraints = false
    time.textAlignment = .center
    time.font = UIFont( name: "Georgia", size: 12)

      button_to_press = UIButton(type: .system)
      button_to_press.translatesAutoresizingMaskIntoConstraints = false
      button_to_press.setTitle("Go back to menu", for: .normal)

      button_to_press.backgroundColor = UIColor.red
      button_to_press.setTitleColor( UIColor.white, for: .normal )
      button_to_press.layer.cornerRadius = 5
      button_to_press.layer.borderWidth = 2
      button_to_press.layer.borderColor = UIColor.black.cgColor
      
      button_to_press.addTarget( nil, action: #selector( ButtonDemoViewController.button_pressed ),
                                 for: .touchUpInside )

    timer = Timer()
    valueTimer = 0
    hits = 0
    seconds = 10
    hit = false
    ball = Ball()
    ball.set_color(UIColor( red: 0.9, green: 1.0, blue: 1.0, alpha: 1.0 ).cgColor)
    ball.deactivate_ball()
    ball.ball_diameter = 0.0
    
    
    time.text = "You will have " + String(seconds) + " seconds !"
    
    
      super.init( frame: frame )
      
      // We will use light 'cyanish' color for the app background.
      backgroundColor = UIColor( red: 0.9, green: 1.0, blue: 1.0, alpha: 1.0 )
      
      addSubview( text_to_show )
      addSubview( button_to_press )
      addSubview(time)
      
      // The following statement specifies that the label will be positioned
      // 96 pixels from the top of the screen.
      
      text_to_show.topAnchor.constraint( equalTo: layoutMarginsGuide.topAnchor,
                                         constant: 30 ).isActive = true
      
      // The following two statements specify that the label is centered horizontally.
      
      text_to_show.leadingAnchor.constraint( equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
      text_to_show.trailingAnchor.constraint( equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
    
    time.topAnchor.constraint( equalTo: layoutMarginsGuide.topAnchor,
                               constant: 80 ).isActive = true
    
    time.leftAnchor.constraint( equalTo: layoutMarginsGuide.leftAnchor,
                                constant: 80 ).isActive = true
    
      // The following statements specify a constant size for the button.
      
      button_to_press.widthAnchor.constraint( equalToConstant: 200 ).isActive = true
      button_to_press.heightAnchor.constraint( equalToConstant: 64 ).isActive = true
      
      // Button in centered horizontally as the label.
      button_to_press.centerXAnchor.constraint( equalTo: text_to_show.centerXAnchor ).isActive = true

      // The button will be 64 pixels below the label.
      button_to_press.topAnchor.constraint( equalTo: centerYAnchor,
                                            constant: 160 ).isActive = true
    
    
   }
    
    func launch_game(){
        time.text = "Be ready ... "
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
            self.button_to_press.isEnabled = false
            self.button_to_press.isHidden = true
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.create_ball), userInfo: nil, repeats: true)
        })
    }
   
   convenience required init(coder aDecoder: NSCoder)
   {
      self.init()
   }
    
    func create_ball(){
        if(valueTimer < seconds){
        hit = false
        
        valueTimer += 1
        let view_width = bounds.size.width
        let view_height = bounds.size.height
        
        ball = Ball( CGFloat(Int(arc4random_uniform(UInt32(view_width)))), CGFloat(Int(arc4random_uniform(UInt32(view_height)))), getRandomColor().cgColor )
        time.text = String(valueTimer) + " seconds"
        
        self.setNeedsDisplay()
        }
            else {
            time.text = "You hit " + String(hits) + " balls in " + String(seconds) + " seconds,"
            switch hits {
            case 0..<(seconds/2):
                time.text = time.text! + "you can do better !"
            case (seconds/2)..<seconds:
                time.text = time.text! + "you are very good!"
            case seconds:
                time.text = time.text! + "perfect, just perfect !"
            default: break
            }
            
            timer.invalidate()
             button_to_press.isEnabled = true
            button_to_press.isHidden = false
         }
        
    }
    
    override func draw(_ rect: CGRect)
    {
        let context: CGContext = UIGraphicsGetCurrentContext()!
        ball.draw(context)
    }
    
    func is_inside(_ sender: UIGestureRecognizer? = nil) {
        let pan_point = sender?.location( in: self )
            if ball.contains_point( pan_point! ) && hit == false {
                hits += 1
                hit = true
            }
    }
    
    func getRandomColor() -> UIColor{
        //Generate between 0 to 1
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
    
}

