//
//  DetailNewsTableViewCell.swift
//  Mansi_Gandhi_FE_8966204
//
//  Created by user240208 on 4/10/24.
//

import UIKit

class DetailNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var athorLbl: UILabel!
    @IBOutlet weak var srcLbl: UILabel!
    @IBOutlet weak var ttlLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    
    func setupUI(article: Article) {
        athorLbl.text = "Author: \(article.author ?? "Unknown")"
        srcLbl.text = "Source: \(article.source?.name ?? "")"
        ttlLbl.text = "Title: \(article.title ?? "")"
        contentLbl.text = "Content: \(article.description ?? "")"
    }
}
