//
//  EasyRoundViewController.swift
//  QuizMe
//
//  Created by Escobido, Matthew George O. on 08/01/2016.
//  Copyright © 2016 AIM. All rights reserved.
//

import UIKit

class EasyRoundViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet var answerButtons: [UIButton]!
    
    var answers = [String]()
    var correctAnswer: String?
    var currentScore: Double = 0.0
    
    
    @IBAction func answerButtonHandler(sender: UIButton) {
        if sender.titleLabel!.text == correctAnswer {
            currentScore++
        } else {
            sender.backgroundColor = UIColor.redColor()
        }
        
        for button in answerButtons {
            button.enabled = false
            if button.titleLabel!.text == correctAnswer {
                button.backgroundColor = UIColor.greenColor()
            }
        }
        nextButton.enabled = true
    }
    
    @IBOutlet var nextButton: UIButton!
    
    var question: String?
    var questionIdx = 0
    var questionInit: String?
    let roundItems = 10
    
    @IBAction func nextButtonHandler(sender: AnyObject) {
        timer.invalidate()
        
        if (questionIdx < roundItems - 1) {
            questionIdx++
            nextButton.enabled = true
            nextQuestion()
        } else {
            showAlert(false)
            addScore()
        }
    }

    var figure: String?
    var myString: NSMutableAttributedString?
    
    func nextQuestion() {
        let currentQuestion = easyQArray![questionIdx]
        
        answers = currentQuestion["Answers"] as! [String]
        correctAnswer = currentQuestion["CorrectAnswer"] as? String
        question = currentQuestion["Question"] as? String
        
        questionInit = currentQuestion["Question"] as? String
        question = questionInit! + "\n"
        
        if let fig = currentQuestion["Figure"] {
            figure = fig as? String
        } else {
            figure = ""
        }
        
        let attachment:NSTextAttachment = NSTextAttachment()
        attachment.image = UIImage(named: figure!)
        let attachmentString:NSAttributedString = NSAttributedString(attachment: attachment)
        myString = (NSMutableAttributedString(string:question!))
        myString!.appendAttributedString(attachmentString)
        
        titlesForButtons()
    }
    
    func titlesForButtons() {
        for (idx, button) in answerButtons.enumerate() {
            button.titleLabel!.lineBreakMode = .ByWordWrapping
            button.setTitle(answers[idx], forState: .Normal)
            button.enabled = true
            button.backgroundColor = UIColor(red: 83.0/255.0, green: 184.0/255.0, blue: 224.0/255.0, alpha: 1.0)
        }
        
        questionLabel.attributedText = myString
        startTimer()
        updateQNumLabel()
    }
    
    @IBOutlet weak var timerLabel: UILabel!
    let timeGiven = 70
    var seconds = 70
    var timer = NSTimer()
    
    func startTimer() {
        seconds = timeGiven
        //timerLabel.text = "Time: \(seconds) s"
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
    }
    
    func updateTime() {
        timerLabel.text = "Time: \(seconds) s"
        seconds--
        if(seconds == 0) {
           outOfTime()
        }
    }
    
    func outOfTime() {
        timer.invalidate()
        showAlert(true)
        highlightAnswerButton()
    }
    
    func highlightAnswerButton() {
        for button in answerButtons {
            if button.titleLabel!.text == correctAnswer {
                button.backgroundColor = UIColor.greenColor()
            }
        }
    }

    func showAlert(slow:Bool) {
        var title: String?
        var message: String?
        var ok: UIAlertAction
        
        if slow {
            title = "Time is up!"
            message = "\(timeGiven)s has passed"
            ok = UIAlertAction(title: "Ok", style: .Default, handler: {(alert: UIAlertAction!) in})
        } else {
            title = "You have completed the round!"
            message = "You have \(currentScore) out of \(roundItems) correct answers"
            ok = UIAlertAction(title: "Ok", style: .Default, handler: {(alert: UIAlertAction!) in self.sendToScores() })
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(ok)
        self.presentViewController(alertController, animated: true, completion: nil)
        nextButton.enabled = true
    }
    
    func sendToScores() {
        /*let vc = self.storyboard!.instantiateViewControllerWithIdentifier("easyScoresViewController") as UIViewController
        self.navigationController!.pushViewController(vc, animated: true)*/
        
        navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    var newArray:[Double] = [0.0]
    
    func addScore() {
        if let oldArray = NSUserDefaults.standardUserDefaults().valueForKey("easyRoundScores") {
            newArray = oldArray as! [Double]
            newArray.append(currentScore)
        } else {
            newArray = [currentScore]
        }
        
        NSUserDefaults.standardUserDefaults().setValue(newArray, forKey: "easyRoundScores")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    @IBOutlet weak var questionNumLabel: UILabel!
    
    func updateQNumLabel() {
        questionNumLabel.text = "\(questionIdx + 1) of \(roundItems)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(patternImage: UIImage(named: "iphone6bg")!)

        nextButton.enabled = false
        easyQArray!.shuffle()
        nextQuestion()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
