//
//  ActivityTracker.swift
//  breakfree
//
//  Created by Akash Gupta on 25/03/20.
//  Copyright © 2020 Akash Gupta. All rights reserved.
//

import Foundation


//let dataManager = DataManager()


struct ActivityTracker : Codable {
    
    
    var noOfMinutes : Float
    var level : Int
    var sessions : Int
    var itemIdentifier:UUID
    
    mutating func updateTracker(_minutes: Float, _level : Int){
        
    self.noOfMinutes += _minutes
    self.level = _level
   self.sessions += 1
    DataManager.save(self, with: itemIdentifier.uuidString)
        
    }
    
    mutating func resetTracker(_minutes: Float){
        
    self.noOfMinutes = 0
    self.level = 1
    self.sessions = 0
    DataManager.save(self, with: itemIdentifier.uuidString)
        
    }
    
    func saveTracker () {
        
        DataManager.save(self, with: itemIdentifier.uuidString)
    }
    
    
    
}
