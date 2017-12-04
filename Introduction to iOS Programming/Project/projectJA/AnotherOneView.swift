//
//  AnotherOneView.swift Copyright Jules AUBRY
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

struct Question {
    var q: String
    var a: String
    var b: String
    var c: String
    var d: Int
}


class AnotherOneView: UIView
{
    let result_to_show: UILabel
    let question: UILabel
    let choice1: UIButton
    let choice2: UIButton
    let choice3: UIButton
    let button_to_be_pressed: UIButton
    var current_question: int_fast32_t
    var hits:Int
    var possible:Bool
    
    var questions: [Question]
    
   
   override init( frame: CGRect )
   {
    result_to_show = UILabel()
    result_to_show.translatesAutoresizingMaskIntoConstraints = false
    result_to_show.textAlignment = .center
    result_to_show.text = "Answer here"
    result_to_show.font = UIFont( name: "Georgia", size: 12 )
    result_to_show.textColor = UIColor.red
    
    question = UILabel()
    question.translatesAutoresizingMaskIntoConstraints = false
    question.textAlignment = .center
    question.text = "Question here"
    question.font = UIFont( name: "Georgia", size: 28 )
    
    choice1 = UIButton(type: .system)
    choice1.translatesAutoresizingMaskIntoConstraints = false
    choice1.setTitle("Choice 1", for: .normal)
    
    choice1.backgroundColor = UIColor.yellow
    choice1.setTitleColor( UIColor.blue, for: .normal )
    
    
    choice2 = UIButton(type: .system)
    choice2.translatesAutoresizingMaskIntoConstraints = false
    choice2.setTitle("Choice 2", for: .normal)
    
    choice2.backgroundColor = UIColor.yellow
    choice2.setTitleColor( UIColor.blue, for: .normal )
    
    choice3 = UIButton(type: .system)
    choice3.translatesAutoresizingMaskIntoConstraints = false
    choice3.setTitle("Choice 3", for: .normal)
    
    choice3.backgroundColor = UIColor.yellow
    choice3.setTitleColor( UIColor.blue, for: .normal )
    
    button_to_be_pressed = UIButton(type: .system)
    button_to_be_pressed.translatesAutoresizingMaskIntoConstraints = false
    button_to_be_pressed.setTitle("Go back to menu", for: .normal)
    
    button_to_be_pressed.backgroundColor = UIColor.red
    button_to_be_pressed.setTitleColor( UIColor.white, for: .normal )
    button_to_be_pressed.layer.cornerRadius = 5
    button_to_be_pressed.layer.borderWidth = 2
    button_to_be_pressed.layer.borderColor = UIColor.black.cgColor
    
    button_to_be_pressed.addTarget( nil, action: #selector( AnotherOneViewController.button_pressed ),
                               for: .touchUpInside )

    
    current_question = -1
    possible = true
    hits = 0
    questions = [Question]()
    questions.append(Question(q:"What is correct ?", a:"Je suis être", b:"Je suis ici", c:"Je suis été", d:2))
    questions.append(Question(q:"What is your name ?", a:"Answer A", b:"Answer B", c:"My name", d:3))
    questions.append(Question(q:"Is that the end ?", a:"Yes", b:"No", c:"Maybe", d:1))
    
    super.init(frame: frame)
    
    result_to_show.isHidden = true
    result_to_show.isEnabled = false
    addSubview( result_to_show )
    addSubview( question )
    addSubview(choice1)
    addSubview(choice2)
    addSubview(choice3)
    addSubview(button_to_be_pressed)
    
    question.widthAnchor.constraint( equalToConstant: 500 ).isActive = true
    question.heightAnchor.constraint( equalToConstant: 100 ).isActive = true
    
    // Button in centered horizontally as the label.
    question.centerXAnchor.constraint( equalTo: leftAnchor, constant : 180 ).isActive = true
    
    // The button will be 64 pixels below the label.
    question.topAnchor.constraint( equalTo: topAnchor, constant: 80).isActive = true
    
    choice1.widthAnchor.constraint( equalToConstant: 200 ).isActive = true
    choice1.heightAnchor.constraint( equalToConstant: 64 ).isActive = true
    
    // Button in centered horizontally as the label.
    choice1.centerXAnchor.constraint( equalTo: centerXAnchor ).isActive = true
    
    // The button will be 64 pixels below the label.
    choice1.topAnchor.constraint( equalTo: topAnchor, constant: 160).isActive = true
    
    choice2.widthAnchor.constraint( equalToConstant: 200 ).isActive = true
    choice2.heightAnchor.constraint( equalToConstant: 64 ).isActive = true
    
    // Button in centered horizontally as the label.
    choice2.centerXAnchor.constraint( equalTo: centerXAnchor ).isActive = true
    
    // The button will be 64 pixels below the label.
    choice2.topAnchor.constraint( equalTo: topAnchor, constant: 240).isActive = true
    
    choice3.widthAnchor.constraint( equalToConstant: 200 ).isActive = true
    choice3.heightAnchor.constraint( equalToConstant: 64 ).isActive = true
    
    // Button in centered horizontally as the label.
    choice3.centerXAnchor.constraint( equalTo: centerXAnchor ).isActive = true
    
    // The button will be 64 pixels below the label.
    choice3.topAnchor.constraint( equalTo: topAnchor, constant: 320).isActive = true
    
    button_to_be_pressed.widthAnchor.constraint( equalToConstant: 200 ).isActive = true
    button_to_be_pressed.heightAnchor.constraint( equalToConstant: 64 ).isActive = true
    
    // Button in centered horizontally as the label.
    button_to_be_pressed.centerXAnchor.constraint( equalTo: centerXAnchor ).isActive = true
    
    // The button will be 64 pixels below the label.
    button_to_be_pressed.topAnchor.constraint( equalTo: topAnchor, constant: 500).isActive = true
    
    
    
    choice1.addTarget(self, action: #selector(button_press(button:)), for: .touchUpInside)
    choice2.addTarget(self, action: #selector(button_press(button:)), for: .touchUpInside)
    choice3.addTarget(self, action: #selector(button_press(button:)), for: .touchUpInside)
    
   }
    
   
   convenience required init(coder aDecoder: NSCoder)
   {
      self.init()
   }
    
    func button_press(button: UIButton) {
        if (possible) {
        
        possible = false
        
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        
        switch button {
        case choice1: validate_answer(number: 1)
        case choice2: validate_answer(number: 2)
        case choice3: validate_answer(number: 3)
            
        default:
            break
        }
            
            if(Int(current_question) < questions.capacity-2){
          DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
              self.next_question()
          })
            }
            else {
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                    self.write_end()
                })
            }
        }
    }
    
    func next_question(){
        removeAllBorders()
        possible = true
        
        current_question = current_question + 1
        
        var number: Int
        number = Int(current_question)
        
        question.text = questions[number].q
        choice1.setTitle(questions[number].a, for: .normal)
        choice2.setTitle(questions[number].b, for: .normal)
        choice3.setTitle(questions[number].c, for: .normal)
    }
    
    func validate_answer(number: Int) {
        var numb: Int
        numb = Int(current_question)
        let answer:Int = questions[numb].d
        
        if(answer == number) {
            hits += 1
            addBorderColorGreen(number: answer)
        }
        else {
            addBorderColorRed(number: answer)
        }
        
        
    }
    
    func addBorderColorGreen(number: Int) {
        switch number {
        case 1:
            choice1.layer.cornerRadius = 5
            choice1.layer.borderWidth = 2
            choice1.layer.borderColor = UIColor.green.cgColor
        case 2:
            choice2.layer.cornerRadius = 5
            choice2.layer.borderWidth = 2
            choice2.layer.borderColor = UIColor.green.cgColor
        case 3:
            choice3.layer.cornerRadius = 5
            choice3.layer.borderWidth = 2
            choice3.layer.borderColor = UIColor.green.cgColor
        default:
            break
        }
    }
    
    func addBorderColorRed(number: Int) {
        switch number {
        case 1:
            choice1.layer.cornerRadius = 5
            choice1.layer.borderWidth = 2
            choice1.layer.borderColor = UIColor.red.cgColor
        case 2:
            choice2.layer.cornerRadius = 5
            choice2.layer.borderWidth = 2
            choice2.layer.borderColor = UIColor.red.cgColor
        case 3:
            choice3.layer.cornerRadius = 5
            choice3.layer.borderWidth = 2
            choice3.layer.borderColor = UIColor.red.cgColor
        default:
            break
        }
    }
    func removeAllBorders(){
        choice1.layer.borderWidth = 0
        choice2.layer.borderWidth = 0
        choice3.layer.borderWidth = 0
    }
    
    func launch_game() {
        next_question()
    }
    
    func write_end() {
        result_to_show.isHidden = false
        result_to_show.isEnabled = true
        question.isHidden = true
        question.isEnabled = false
        choice1.isHidden = true
        choice1.isEnabled = false
        choice2.isHidden = true
        choice2.isEnabled = false
        choice3.isHidden = true
        choice3.isEnabled = false
        
        result_to_show.widthAnchor.constraint( equalToConstant: 200 ).isActive = true
        result_to_show.heightAnchor.constraint( equalToConstant: 64 ).isActive = true
        
        // Button in centered horizontally as the label.
        result_to_show.centerXAnchor.constraint( equalTo: centerXAnchor ).isActive = true
        
        // The button will be 64 pixels below the label.
        result_to_show.topAnchor.constraint( equalTo: topAnchor, constant: 160).isActive = true
        
        result_to_show.text = "You scored " + String(hits) + ","
        switch hits {
        case 0..<((questions.capacity-1)/2):
            result_to_show.text = result_to_show.text! + "you can do better !"
        case (questions.capacity-1)/2..<(questions.capacity-1):
            result_to_show.text = result_to_show.text! + "you are very good!"
        case (questions.capacity-1):
            result_to_show.text = result_to_show.text! + "perfect, just perfect !"
        default: break
        }
    }
    
}

