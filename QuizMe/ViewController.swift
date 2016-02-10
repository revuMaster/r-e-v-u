//
//  ViewController.swift
//  QuizMe
//
//  Created by Escobido, Matthew George O. on 08/01/2016.
//  Copyright © 2016 AIM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //lview.backgroundColor = UIColor(patternImage: UIImage(named: "iphone6bg")!)
        
        loadQuizData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func loadQuizData() {
        //easy round
        let pathEasy = NSBundle.mainBundle().pathForResource("EasyRound", ofType: "plist")
        let dictEasy = NSDictionary(contentsOfFile: pathEasy!)
        easyQArray = dictEasy!["Questions"]!.mutableCopy() as? Array
        
        //average round
        let pathAverage = NSBundle.mainBundle().pathForResource("AverageRound", ofType: "plist")
        let dictAverage = NSDictionary(contentsOfFile: pathAverage!)
        averageQArray = dictAverage!["Questions"]!.mutableCopy() as? Array
        
        //difficult round
        let pathDifficult = NSBundle.mainBundle().pathForResource("DifficultRound", ofType: "plist")
        let dictDifficult = NSDictionary(contentsOfFile: pathDifficult!)
        difficultQArray = dictDifficult!["Questions"]!.mutableCopy() as? Array
        
        //full round
        let pathFull = NSBundle.mainBundle().pathForResource("FullRound", ofType: "plist")
        let dictFull = NSDictionary(contentsOfFile: pathFull!)
        fullQArray = dictFull!["Questions"]!.mutableCopy() as? Array
        
        //check()
    }
    
    func check() {
        print(easyQArray)
        print(averageQArray)
        print(difficultQArray)
        print(fullQArray)
    }
    
}

