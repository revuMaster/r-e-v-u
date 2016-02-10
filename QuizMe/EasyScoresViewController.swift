//
//  EasyScoresViewController.swift
//  QuizMe
//
//  Created by Escobido, Matthew George O. on 26/01/2016.
//  Copyright © 2016 AIM. All rights reserved.
//

import UIKit
import Charts


class EasyScoresViewController: UIViewController {
    @IBOutlet weak var lineChartView: LineChartView!

    var attemptEntries:[String]!
    
    func setChart(numTicks:Int, values:[Double]) {
        //barChartView.noDataText = "Provide data for the chart"
        
        var dataEntries:[ChartDataEntry] = []
        var tickMarks:[String]! = []
        
        for i in 0..<numTicks {
            let dataEntry = ChartDataEntry(value:values[i], xIndex:i)
            let tick = String(i)
            dataEntries.append(dataEntry)
            tickMarks.append(tick)
        }
        
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Scores")
        let lineChartData = LineChartData(xVals: tickMarks, dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        var numRound:Int = 0
        var easyScoresData:[Double] = []
        
        if let easyScoresRead = NSUserDefaults.standardUserDefaults().valueForKey("easyRoundScores") {
            easyScoresData = easyScoresRead as! [Double]
            print("We saved this data: \(easyScoresRead)")
            numRound = easyScoresRead.count
        }
        
        setChart(numRound, values:easyScoresData)
        
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
