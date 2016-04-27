//
//  buttonview.swift
//  pitchperfect
//
//  Created by kavita patel on 3/30/16.
//  Copyright © 2016 kavita patel. All rights reserved.
//

import UIKit

class buttonView: UIButton {

    override func awakeFromNib() {
        
        layer.cornerRadius = 2.0
        layer.shadowColor = UIColor(red: 0.4, green: 0.2, blue: 0.6, alpha: 0.5).CGColor
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSizeMake(0.0, 2.0)
        
    }

}
