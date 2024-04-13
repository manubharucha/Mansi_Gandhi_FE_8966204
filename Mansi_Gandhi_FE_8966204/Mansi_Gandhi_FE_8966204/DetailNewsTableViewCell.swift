//
//  DetailNewsTableViewCell.swift
//  Mansi_Gandhi_FE_8966204
//
//  Created by user240208 on 4/10/24.
//

import UIKit

class DetailNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    
    // Here I created a custom method to set up the UI of the cell with data from an article.
    func setupUI(article: Article) {
        authorName.text = "Author: \(article.author ?? "Unknown")"
        source.text = "Source: \(article.source?.name ?? "")"
        title.text = "Title: \(article.title ?? "")"
        content.text = "Content: \(article.description ?? "")"
    }
}
