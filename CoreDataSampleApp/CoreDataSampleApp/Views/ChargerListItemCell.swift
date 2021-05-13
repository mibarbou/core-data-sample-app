//
//  ChargerListItemCell.swift
//  MyWallbox
//
//  Created by Santi on 28/8/18.
//  Copyright © 2018 Wallbox Chargers. All rights reserved.
//

import UIKit
//import Kingfisher

class ChargerListItemCell: UITableViewCell {

	static let identifier = "ChargerListItemCell"
	
	@IBOutlet weak var chargerNameLabel: UILabel!
	@IBOutlet weak var container: UIView!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var chargerImageView: UIImageView!
    @IBOutlet weak var bluetoothImageView: UIImageView!
    @IBOutlet weak var internetConnectionImageView: UIImageView!
    @IBOutlet weak var blockedImageView: UIImageView!
    @IBOutlet weak var blockedView: UIView!
    
	override func awakeFromNib() {
        super.awakeFromNib()
        
		container.layer.cornerRadius = 10
        
        chargerNameLabel.adjustsFontSizeToFitWidth = true
        chargerNameLabel.minimumScaleFactor = 0.7
		
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOpacity = 0.25
		layer.shadowOffset = CGSize(width: 1, height: 1)
		layer.shadowRadius = 4
		
        chargerImageView.contentMode = .scaleAspectFill
        
        blockedView.layer.cornerRadius = blockedView.frame.width / 2
        
        blockedView.layer.borderColor = UIColor.white.cgColor
        blockedView.layer.borderWidth = 1
        
        chargerImageView.alpha = 0.75
		selectionStyle = .none
		
		internetConnectionImageView.image = nil
		internetConnectionImageView.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
    }
    
//    func bind(charger: ChargerViewModel) {
//        chargerNameLabel.text = charger.name.uppercased()
//        stateLabel.text = charger.state
//
//        chargerImageView.kf.setImage(with: charger.image)
//
//
//		if let mode = charger.connectivity {
//			internetConnectionImageView.image = mode.image
//		}
//
//        bluetoothImageView.isHidden = !charger.isBluetoothInRange
//        internetConnectionImageView.isHidden = !charger.internetConnectionActivated
//
//        let (firstColor, secondColor) = charger.state.colors
//        container.updateColors(secondColor, firstColor, .topToBottom)
//
//        blockedImageView.image = charger.locked ? UIImage(named: "charger_locked_icon")?.tinted : UIImage(named: "charger_unlocked_icon")?.tinted
//		blockedView.backgroundColor = charger.state.lockColor
//
//		blockedView.isHidden = !charger.showLock
//    }
    
}


