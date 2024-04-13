//
//  News.swift
//  Mansi_Gandhi_FE_8966204
//
//  Created by user240208 on 4/10/24.
//

import UIKit

// Here I created a UITableViewController subclass to display news articles.
class News: UITableViewController {

    var newsArray: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.title = "Local News"
        fetchNews(cityName: "Kitchener")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(rightBarButtonTapped))
        self.tabBarController?.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    // here i created Method to handle tapping the right bar button item to input city name for news.
    @objc func rightBarButtonTapped() {
        showCityInputAlert(on: self, title: "Enter City Name", message: "Enter City name for News") { cityName in
            self.fetchNews(cityName: cityName)
        }
    }
    
    // here i created Method to fetch news articles based on the provided city name.
    func fetchNews(cityName: String) {
        let url = "https://newsapi.org/v2/everything?q=\(cityName)&apiKey=8203dc1ea54e42e8a04d6d418763e8b4" 
        guard let url = URL(string: url) else { return }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching news: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            do {
                let decoder = JSONDecoder()
                let NewsRespo = try decoder.decode(NewsModel.self, from: data)
                self?.newsArray = NewsRespo.articles
                self?.saveNews(article: NewsRespo.articles.first!, cityName: cityName)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } catch {
                print("Error decoding news data: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    // Here I created methods to specify the number of sections and rows in the table view, as well as to configure cells.
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    // Here I created an method to configure cells for displaying news articles.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailNewsTableViewCell", for: indexPath) as? DetailNewsTableViewCell else { return UITableViewCell() }
        cell.setupUI(article: self.newsArray[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    // here i created Method to save the first news article along with city name.
    func saveNews(article: Article, cityName: String) {
        DataSavingManager.shared.saveNews(author: article.author ?? "",
                             cityName: cityName,
                             content: article.content ?? "",
                             from: "News",
                             source: article.source?.name ?? "",
                             title: article.title ?? "")
    }
    
}
