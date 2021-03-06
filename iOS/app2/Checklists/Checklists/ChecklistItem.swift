//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Akash on 23/12/17.
//  Copyright © 2017 atomicnumber1. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject {
    
    var text: String
    var checked: Bool
    
    init(text: String = "", checked: Bool = false) {
        self.text = text
        self.checked = checked
    }
    
    func toggleChecked() {
        checked = !checked
    }
}
