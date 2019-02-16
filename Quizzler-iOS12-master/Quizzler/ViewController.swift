//
//  ViewController.swift
//  Quizzler
//
//  Created by Gautham MK on 15/2/2019
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    
    let allQuestions = QuestionBank()
	var pickedAnswer :Bool = false
	var questionNumber : Int = 0
	var score: Int = 0
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
		updateUI()
		nextQuestion()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
		if(sender.tag == 1){
			pickedAnswer = true
		}
		else if(sender.tag == 2){
			pickedAnswer = false
		}
			checkAnswer()
			questionNumber = questionNumber + 1
			nextQuestion()
    }
    
    
    func updateUI() {
		scoreLabel.text = "Score: \(score)"
		progressLabel.text = "\(questionNumber)/13"
		progressBar.frame.size.width = (view.frame.size.width)/13 * CGFloat(questionNumber)
    }
    

    func nextQuestion() {
		updateUI()
		if(questionNumber <= 12){
			questionLabel.text = allQuestions.list[questionNumber].questionText
		}
		else{
			print("End of quiz.")
			let alert = UIAlertController(title: "Awesome!", message: "You have finsihed all the questions. Do you want to start over?", preferredStyle: .alert)
			let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
				self.startOver()
			}
			alert.addAction(restartAction)
			present(alert,animated: true,completion: nil)
		}
		
    }
    
    
    func checkAnswer() {
        let correctAnswer = allQuestions.list[questionNumber].answer
		if(pickedAnswer == correctAnswer){
			ProgressHUD.showSuccess("Correct!")
			print("Yay!Correct answer")
			score = score + 1
		}
		else{
			ProgressHUD.showError("Wrong!")
			print("haha fail.")
		}
    }
    
    
    func startOver() {
       	questionNumber = 0
		score = 0
		nextQuestion()
    }
    

    
}
