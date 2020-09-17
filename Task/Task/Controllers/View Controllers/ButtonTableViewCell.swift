//
//  ButtonTableViewCell.swift
//  Task
//
//  Created by Trevor Bursach on 9/17/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import UIKit

protocol ButtonTableViewCellDelegate {
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell)
}

class ButtonTableViewCell: UITableViewCell {
    
    var delegate: ButtonTableViewCellDelegate?

    // Outlets
    
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    //Actions
    
    @IBAction func buttonTapped(_ sender: Any) {
        delegate?.buttonCellButtonTapped(self)
//        updateButton(isComplete: true)
    }
    
    
    func updateButton(isComplete: Bool) {
        
        let imageName = isComplete ? "complete" : "incomplete"
        completeButton.setImage(UIImage(named: imageName), for: .normal)
        
//        let button = completeButton
//
//        if isComplete == true {
//            button?.setImage(UIImage(named: "complete"), for: .normal)
//        } else {
//            button?.setImage(UIImage(named: "incomplete"), for: .normal)
//        }
    }
} // END OF CLASS

extension ButtonTableViewCell {
    func update(withTask task: Task) {
        primaryLabel.text = task.name
        updateButton(isComplete: task.isComplete)
    }
}
