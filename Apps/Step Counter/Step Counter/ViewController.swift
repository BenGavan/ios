//
//  ViewController.swift
//  Step Counter
//
//  Created by Ben Gavan on 23/02/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit
import CoreMotion
import HealthKit

class ViewController: UIViewController {
    
    var days:[String] = []
    var stepsTaken:[Int] = []
    
    let activityManager = CMMotionActivityManager()
    let pedoMeter = CMPedometer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "HI"
        label.textAlignment = .center
        
        self.view.addSubview(label)
        
        label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        var calender = NSCalendar.current
        
        let timeZone = NSTimeZone.system
        calender.timeZone = timeZone
        
        retrieveStepCount()
        
    }
    
    
    func retrieveStepCount() {
        
        //   Define the Step Quantity Type
        let stepsCount = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        
        let storage = HKHealthStore()
        
        //   Get the start of the day
        let date = Date()
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let newDate = cal.startOfDay(for: date)
        
        //  Set the Predicates & Interval
        let predicate = HKQuery.predicateForSamples(withStart: newDate, end: Date(), options: .strictStartDate)
        var interval = DateComponents()
        interval.day = 1
        
        //  Perform the Query
        let query = HKStatisticsCollectionQuery(quantityType: stepsCount!, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: newDate as Date, intervalComponents:interval)
        
        query.initialResultsHandler = { query, results, error in
            
            if error != nil {
                
                //  Something went Wrong
                print(error)
                return
            }
            
            if let myResults = results{
                
                print(myResults)
                
                
                
//                myResults.enumerateStatistics(from: Date(timeIntervalSince1970: TimeInterval(1000000)), to: Date()) { statistics, stop in
//
//                    if let quantity = statistics.sumQuantity() {
//
//                        let steps = quantity.doubleValue(for: HKUnit.count())
//
//                        print("Steps = \(steps)")
//
//                    }
//                }
            }
            
            
        }
        
        storage.execute(query)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

