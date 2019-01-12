//
//  GradientButton.swift
//  PassionExperties
//
//  Created by shalu tyagi on 13/01/19.
//  Copyright © 2019 shalu tyagi. All rights reserved.
//

class GradientButton: UIButton, Round {
  
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)    
    let startColor = #colorLiteral(red: 0.2235294118, green: 0.9254901961, blue: 0.7333333333, alpha: 1)
    let endColor = #colorLiteral(red: 0.1490196078, green: 0.6745098039, blue: 0.9529411765, alpha: 1)
    self.setGradientBackgroundColors([startColor, endColor], direction: .toRight, for: .normal)
    self.round()
  }
}
