//
//  SettingsViewController.swift
//  QuizMe
//
//  Created by Escobido, Matthew George O. on 08/01/2016.
//  Copyright © 2016 AIM. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
    @IBOutlet var quizModeButtons: [UIButton]!
  
    @IBAction func quizModeButtonHandler(sender: UIButton) {
        for button in quizModeButtons {
            if sender != button {
                button.alpha = 0.5
            } else {
                button.alpha = 1.0
                quizMode = button.tag
            }
        }
    }
    
    @IBAction func playButtonHandler(sender: AnyObject) {
        var vc: UIViewController?
        switch quizMode {
        case 0: //Easy Round 
            vc = storyboard?.instantiateViewControllerWithIdentifier("easyRoundViewController") as! EasyRoundViewController
            break
        case 1: //Average Round
            vc = storyboard?.instantiateViewControllerWithIdentifier("averageRoundViewController") as! AverageRoundViewController
            break
        case 2: //Difficult Round
            vc = storyboard?.instantiateViewControllerWithIdentifier("difficultRoundViewController") as! DifficultRoundViewController
            break
        case 3: //Full Round
            vc = storyboard?.instantiateViewControllerWithIdentifier("fullRoundViewController") as! FullRoundViewController
            break
        default:
            break
        }
        if vc != nil {
            navigationController?.pushViewController(vc!, animated: true)
        }
        
    }
    
    var quizMode = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(patternImage: UIImage(named: "iphone6bg")!)
        
        for (idx, button) in quizModeButtons.enumerate() {
            button.tag = idx
            if button.tag != 0 {
                button.alpha = 0.5
            }
            
        }
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
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
