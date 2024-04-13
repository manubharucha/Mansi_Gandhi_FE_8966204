//
//  NewsTableViewCell.swift
//  Mansi_Gandhi_FE_8966204
//
//  Created by user240208 on 4/10/24.
//

import UIKit


// Here I created a UITableViewCell subclass to display news data.
class NewsDataTableViewCell: UITableViewCell {

    @IBOutlet weak var Author: UILabel!
    @IBOutlet weak var Source: UILabel!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var FromHome: UILabel!
    @IBOutlet weak var Conent: UILabel!
    @IBOutlet weak var CityName: UILabel!
    
    func setupCell(data: NewsData) {
        Author.text = "Author: \(data.authorofnews ?? "")"
        Source.text = "Source: \(data.source ?? "")"
        Title.text = "Title: \(data.titleofnews ?? "")"
        FromHome.text = "From: \(data.from ?? "")"
        Conent.text = "Content: \(data.content ?? "")"
        CityName.text = "City Name: \(data.nameofcity ?? "")"
    }

}
