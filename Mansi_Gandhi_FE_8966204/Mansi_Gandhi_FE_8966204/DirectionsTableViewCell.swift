//
//  DirectionsTableViewCell.swift
//  Mansi_Gandhi_FE_8966204
//
//  Created by user240208 on 4/10/24.
//

import UIKit

class DirectionsTableViewCell: UITableViewCell {

    @IBOutlet weak var Cityname: UILabel!
    @IBOutlet weak var Distancetravelled: UILabel!
    @IBOutlet weak var Modeoftravel: UILabel!
    @IBOutlet weak var Endpoint: UILabel!
    @IBOutlet weak var Startpoint: UILabel!
    
    func setup(data: DirectionsData) {
        Cityname.text = data.citynames ?? ""
        Distancetravelled.text = data.totaldistance ?? ""
        Modeoftravel.text = data.methodoftravel
        Endpoint.text = data.endPoint ?? ""
        Startpoint.text = data.startingpoint ?? ""
    }
}
