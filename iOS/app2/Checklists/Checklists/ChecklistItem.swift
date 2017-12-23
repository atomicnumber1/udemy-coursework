//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Akash on 23/12/17.
//  Copyright © 2017 atomicnumber1. All rights reserved.
//

import Foundation

class ChecklistItem {
    
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
}
