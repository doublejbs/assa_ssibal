//
//  CustomTextField.swift
//  TimeTable
//
//  Created by 송종훈 on 2017. 5. 23..
//  Copyright © 2017년 swiftBook. All rights reserved.
//

import Foundation
import UIKit


class CustomView: UIView {

    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
