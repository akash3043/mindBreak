//
//  ViewController.swift
//  breakfree
//
//  Created by Akash Gupta on 18/03/20.
//  Copyright © 2020 Akash Gupta. All rights reserved.
//

import UIKit

import AVFoundation


var activityArray : Array<ActivityTracker>!
 //var activityTracker = ActivityTracker(noOfMinutes: 0, level: 1, itemIdentifier: UUID())

class ViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    @IBOutlet weak var level: UILabel!
    
    @IBOutlet weak var sessions: UILabel!
    
    @IBOutlet weak var totalTime: UILabel!
    
    
    @IBOutlet weak var medTime: UIPickerView!
    
    
    @IBAction func playButton(_ sender: Any) {
        
       //print(intSelected)
    }
    
    
    
    
    let timeInt = ["1 min", "2 min","3 min","4 min","5 min","6 min","7 min","8 min","9 min","10 min"]
    //let timeInt = ["1", "2","3","4","5","6","7","8","9","10"]
    
    var intSelected : Int?
    
   
    
    func numberOfComponents(in medTime: UIPickerView) -> Int {
        return 1
        }
    
    func pickerView(_ medTime: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeInt.count
        }
    
    func pickerView(_ medTime: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return timeInt[row]
        }
    
    func pickerView(_ medTime: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let random = String(timeInt[row].dropLast(4))
        intSelected = Int(random)
        }
    
    func pickerView(_ medTime: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50;
    }
    
   // var activityTracker = ActivityTracker(noOfMinutes: 0, level: 1, itemIdentifier: UUID())
    
            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       //print ("Welcome\(activityArray)")
       medTime.delegate = self
       medTime.dataSource = self
       medTime.setValue(UIColor.white, forKeyPath: "textColor")
       medTime.selectRow(4, inComponent: 0, animated: true)
       let random = String(timeInt[4].dropLast(4))
       intSelected = Int(random)
        
      
        
        
        
        /*for item in activityArray{
            
            DataManager.delete(item.itemIdentifier.uuidString)
        }*/

        
       DataManager.delete("6B02C742-2748-47A2-8FDD-811D2ED3BCE9")
        
        activityArray = DataManager.loadAll(ActivityTracker.self)
        
        
        print(activityArray)
        
        
        
        
        
        //print("welcome\(activityArray)")
        
        
        
        if activityArray.count==0{
            
            //activityTracker = activityArray[0]
            let activityTracker = ActivityTracker(noOfMinutes: 0, level: 1,sessions : 0, itemIdentifier: UUID())
            
        totalTime.text = "\(activityTracker.noOfMinutes) Min"
            
        sessions.text = "\(activityTracker.sessions) Sessions"
            
        level.text = "Level \(activityTracker.level)"
            
            activityTracker.saveTracker()
            
            activityArray = DataManager.loadAll(ActivityTracker.self)
            
            
        }else{
            
            let activityTracker2 = activityArray[0]
           // activtyLabel.text = "Total Time : \(activityTracker2.noOfMinutes) min"
            //userLevel.text = "Level \(activityTracker2.level)"
            
          totalTime.text = "\(activityTracker2.noOfMinutes) Min"
            
         sessions.text = "\(activityTracker2.sessions) Sessions"
            
            level.text = "Level \(activityTracker2.level)"
        }
    
        


        
       
        
       }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeToPlay" {
            
            if let playVC = segue.destination as? PlayViewController{
                
                
            playVC.playValue = (intSelected ?? 0)*60
                
                }
            }
        }



}
