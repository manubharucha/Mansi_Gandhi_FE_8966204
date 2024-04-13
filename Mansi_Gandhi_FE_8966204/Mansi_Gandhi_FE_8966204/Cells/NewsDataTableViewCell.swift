//
//  NewsTableViewCell.swift
//  Mansi_Gandhi_FE_8966204
//
//  Created by user240208 on 4/10/24.

import UIKit

class NewsDataTableViewCell: UITableViewCell {

    @IBOutlet weak var athrLbl: UILabel!
    @IBOutlet weak var srclbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var fromLbl: UILabel!
    @IBOutlet weak var contantLbl: UILabel!
    @IBOutlet weak var ctyLbl: UILabel!
    
    func setupCell(data: NewsData) {
        athrLbl.text = "Author: \(data.author ?? "")"
        srclbl.text = "Source: \(data.source ?? "")"
        titleLbl.text = "Title: \(data.title ?? "")"
        fromLbl.text = "From: \(data.from ?? "")"
        contantLbl.text = "Content: \(data.content ?? "")"
        ctyLbl.text = "City Name: \(data.cityName ?? "")"
    }

}
