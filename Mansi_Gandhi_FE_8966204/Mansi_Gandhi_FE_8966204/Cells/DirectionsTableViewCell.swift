//
//  DirectionsTableViewCell.swift
//  Mansi_Gandhi_FE_8966204
//
//  Created by user240208 on 4/10/24.
//
import UIKit

class DirectionsTableViewCell: UITableViewCell {

    @IBOutlet weak var ctyNamelbl: UILabel!
    @IBOutlet weak var dstTravelled: UILabel!
    @IBOutlet weak var modeOfTavel: UILabel!
    @IBOutlet weak var endLbl: UILabel!
    @IBOutlet weak var strtlbl: UILabel!
    
    func setup(data: DirectionsData) {
        ctyNamelbl.text = data.cityName ?? ""
        dstTravelled.text = data.distance ?? ""
        modeOfTavel.text = data.method
        endLbl.text = data.endPoint ?? ""
        strtlbl.text = data.startPoint ?? ""
    }
}
