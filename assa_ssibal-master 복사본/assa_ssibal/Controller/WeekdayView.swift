//
//  WeekdayView.swift
//  AddSubjectView
//
//  Created by 송종훈 on 2017. 4. 8..
//  Copyright © 2017년 swiftBook. All rights reserved.
//

import Foundation
import UIKit

class WeekdayView: UIView {
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.frame = self.bounds
        label.textAlignment = .center
        label.textColor = UIColor.darkGray
        addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
