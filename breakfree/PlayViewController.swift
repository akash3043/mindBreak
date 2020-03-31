//
//  PlayViewController.swift
//  breakfree
//
//  Created by Akash Gupta on 18/03/20.
//  Copyright © 2020 Akash Gupta. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {
    
    
    

    
    
    //@IBOutlet weak var playLabel: UILabel!
    
    @IBOutlet weak var pauseButton: UIButton!
    
    let circleLayer = CAShapeLayer()

   
    
    
    var playValue : Int = 0
    
    var repetition : Int = 0
    
    var activityTime : Float = 0
    
    var tempPlayValue : Int = 0
    

    

    
    
      
    var timer = Timer()
    
    var animationTimer = Timer()
    
      
    var isTimerPaused = false
    
    var isCycleCompleted = false
    
    
    
    override func viewDidLoad() {
           
        super.viewDidLoad()
       // playLabel.text = "\(playValue)"
        
       // playLabel.isHidden = false
        
        tempPlayValue = playValue
        
        activityTime = Float(playValue/60)
        
        repetition = Int(ceil(Double(playValue)/8.0))
        
        //print(repetition)
        
        createCircle(view: view)

        playTimer()
        
        circleSizeAnimation()
        
        
          
        }
    
     
    func createCircle (view : UIView){
        
        let center = view.center
        
        let circlePath = UIBezierPath(arcCenter: center, radius: 50, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi/2, clockwise: true)
        
        circleLayer.path = circlePath.cgPath
        
        circleLayer.fillColor = UIColor.blue.cgColor
        
        
        view.layer.addSublayer(circleLayer)
        
        
        
    }
    
    
    @IBAction func pause(_ sender: UIButton) {
        
        if (isTimerPaused==false){
            
            if(isCycleCompleted==false){
            
            timer.invalidate()
            animationTimer.invalidate()
            pauseCircleAnimation()
            isTimerPaused = true
                pauseButton.setImage(UIImage(named: "play"), for: .normal)
            
            }else {
                tempPlayValue = playValue
                playTimer()
                circleSizeAnimation()
                pauseButton.setImage(UIImage(named: "pause"), for: .normal)
                //pauseButton.setTitle("Pause", for: .normal)
                isCycleCompleted = false
                
            }
            
            }else{
                
                playTimer()
                resumeCircleAnimation()
                isTimerPaused = false
                pauseButton.setTitle("Pause", for: .normal)

            }
        
    }
    

    
    func circleSizeAnimation() {
        
        //print ("circle animation")
        
        let radiusAnimation = CABasicAnimation(keyPath: "path")
        let newPath = UIBezierPath(arcCenter: view.center, radius: 75, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi/2, clockwise: true)
        radiusAnimation.toValue = newPath.cgPath
        radiusAnimation.duration = 4
        radiusAnimation.fillMode = CAMediaTimingFillMode.forwards
        radiusAnimation.autoreverses = true
        radiusAnimation.repeatCount = Float(repetition)
        

        
        circleLayer.add(radiusAnimation, forKey: "CircleSize")
        
       

          
}
     
    func pauseCircleAnimation(){
        
        
        let pausedTime = circleLayer.convertTime(CACurrentMediaTime(), from: nil)
        circleLayer.speed = 0.0
        circleLayer.timeOffset = pausedTime
    
        
        
                  
    }
    
    
    func resumeCircleAnimation(){
        
        let pausedTime = circleLayer.timeOffset
        circleLayer.speed = 1.0
        circleLayer.timeOffset = 0.0
        circleLayer.beginTime = 0.0
        let timeSincePause = circleLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        circleLayer.beginTime = timeSincePause
        
       
    }
    
    
    
    
    
  
    func playTimer (){
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(PlayViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        
            if tempPlayValue>0 {
            
                tempPlayValue-=1
                //playLabel.text="\(tempPlayValue)"
            
            }else{
            
                timer.invalidate()
                //playLabel.text="\(tempPlayValue)"
                //pauseButton.setTitle("Restart", for: .normal)
                pauseButton.setImage(UIImage(named: "restart"), for: .normal)
                isCycleCompleted = true
                activityArray = DataManager.loadAll(ActivityTracker.self)
                var activityTracker = activityArray[0]
                let level = Int((activityTracker.noOfMinutes+activityTime)/5)+1
                activityTracker.updateTracker(_minutes: activityTime, _level: level)
                
 
            }
            
        }
    
    
    
    }

  
  
    
   


