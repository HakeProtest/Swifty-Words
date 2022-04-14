//
//  ViewController.swift
//  Project8
//
//  Created by Hafizh Caesandro Kevinoza on 12/04/22.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    var cluesLabel: UILabel!
    var answersLabel: UILabel!
    var currentAnswer: UITextField!
    var scoreLabel: UILabel!
    
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    var score = 0
    var level = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func loadView() {
        // UIView() = An object that manages the content for a rectangular area on the screen.
        view = UIView()
        // display view background white with default value is black
        view.backgroundColor = .white
        
        // MARK: Score Label
        // display label for score
        scoreLabel = UILabel()
        // translatesAutoresizingMaskIntoConstraints = A Boolean value that determines whether the view’s autoresizing mask is translated into Auto Layout constraints.
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        // textAlignment = The technique for aligning the text.
        scoreLabel.textAlignment = .right
        // text = The text that the label displays.
        scoreLabel.text = "Score: 0"
        // addSubview = Adds a view to the end of the receiver’s list of subviews.
        view.addSubview(scoreLabel)
        // NSLayoutConstraint = The relationship between two user interface objects that must be satisfied by the constraint-based layout system.
        // activate = Activates each constraint in the specified array.
        // MARK: cluesLabel
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
//        cluesLabel.textAlignment = .left
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.text = "Clues"
        // numberOfLines = The maximum number of lines for rendering text.
        cluesLabel.numberOfLines = 0
        view.addSubview(cluesLabel)
        // MARK: answerLabel
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.textAlignment = .right
        answersLabel.text = "Answers"
        answersLabel.numberOfLines = 0
        view.addSubview(answersLabel)
        
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        // MARK: currentAnswerTextField
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.textAlignment = .center
        // font = The font of the text.
        // UIFont = An object that provides access to the font’s characteristics.
        // systemFont = Returns the font object for standard interface items in the specified size.
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
        // MARK: submitButton
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        view.addSubview(submit)
        // MARK: clearButton
        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        view.addSubview(clear)
        // MARK: sad
        let buttonView = UIView()
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.backgroundColor = .gray
        view.addSubview(buttonView)
        
        // MARK: NSLayoutConstraint
        NSLayoutConstraint.activate([
            // Score Label
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 0),
            // Clues Label
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
            cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
            // Answer Label
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
            answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
            // Current Answer
            currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            // Submit
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            submit.heightAnchor.constraint(equalToConstant: 44),
            // Clear
            clear.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            clear.heightAnchor.constraint(equalToConstant: 44),
            // Butoon View
            buttonView.widthAnchor.constraint(equalToConstant: 750),
            // Our buttons view should be pinned to the bottom and be exactly 320 points high.
            // The box that will contain button for posible input
            buttonView.heightAnchor.constraint(equalToConstant: 320),
            buttonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
            buttonView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
        ])
        // set some values for the width and height of each button
        let width = 150
        let height = 80
        //
        for row in 0..<4 {
            for col in 0..<5 {
                // create a new button and give it a big font size
                // UIButton = A control that executes your custom code in response to user interactions.
                let letterButton = UIButton(type: .system)
                // titleLabel = A view that displays the value of the currentTitle property for a button.
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                // give the button some temporary text so we can see it on-screen
                // setTitle(...) = Sets the title to use for the specified state.
                letterButton.setTitle("WWW", for: .normal)
                // CGRect(...) = A structure that contains the location and dimensions of a rectangle.
                let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
                // .frame = The frame rectangle, which describes the view’s location and size in its superview’s coordinate system.
                letterButton.frame = frame
                // add letterButton onto buttonsView
                buttonView.addSubview(letterButton)
                // add letter to letterButton Array
                letterButtons.append(letterButton)

            }
        }
    }
    
    // MARK: OBJC
    @objc func letterTapped(_ sender: UIButton) {
        
    }
    
    @objc func submitTapped(_ sender: UIButton) {
        
    }
    
    @objc func clearTapped(_ sender: UIButton) {
        
    }
    var Sam = "Samiel"
}

