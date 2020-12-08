//
//  ViewController.swift
//  WhatTheFoxSay
//
//  Created by Lex Torbanov on 02.12.2020.
//

import UIKit

class ViewController: UIViewController	{
    var movies = Array<FilmInfo>()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie_info = getElementsFromJsonFile(){
            if let movies = movie_info["Search"] {
                for movie in movies {
                    self.movies.append(FilmInfo(title: movie["Title"]!, year: movie["Year"]!, imdbID: movie["imdbID"]!, type: movie["Type"]!, poster: movie["Poster"]!))
                }
            }
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 200
    }
    
    private func getElementsFromJsonFile() -> [String: [[String: String]]]?{
        if let path = Bundle.main.path(forResource: "MoviesList", ofType: "txt"){
            if let text = try? String(contentsOfFile: path){
                if let data = text.data(using: .utf8){
                    do{
                        return try JSONSerialization.jsonObject(with: data, options: []) as? [String: [[String: String]]]
                    } catch{
                        print(error.localizedDescription)
                    }
                }
            }
        }
        return nil
    }
}
extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        cell.movie = self.movies[indexPath.row]
        cell.layoutSubviews()
        return cell
    }
}
extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
class MovieCell: UITableViewCell{
    var movie: FilmInfo?
    
    var titleL: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    var yearL: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var typeL: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var posterIV: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(posterIV)
        self.addSubview(titleL)
        self.addSubview(yearL)
        self.addSubview(typeL)
        
        let off: CGFloat = 8
        
        posterIV.layer.cornerRadius = 8;
        posterIV.layer.masksToBounds = true;
        posterIV.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        posterIV.topAnchor.constraint(equalTo: self.topAnchor, constant: off).isActive = true
        posterIV.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -off).isActive = true
        posterIV.heightAnchor.constraint(equalToConstant: 150).isActive = true
        posterIV.widthAnchor.constraint(equalToConstant: 100).isActive = true

        titleL.leftAnchor.constraint(equalTo: self.posterIV.rightAnchor, constant: off).isActive = true
        titleL.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -off).isActive = true
        titleL.topAnchor.constraint(equalTo: self.posterIV.topAnchor).isActive = true
        
        yearL.leftAnchor.constraint(equalTo: self.titleL.leftAnchor).isActive = true
        yearL.rightAnchor.constraint(equalTo: self.titleL.rightAnchor).isActive = true
        yearL.topAnchor.constraint(equalTo: self.titleL.bottomAnchor, constant: off).isActive = true

        typeL.leftAnchor.constraint(equalTo: self.titleL.leftAnchor).isActive = true
        typeL.rightAnchor.constraint(equalTo: self.titleL.rightAnchor).isActive = true
        typeL.topAnchor.constraint(equalTo: self.yearL.bottomAnchor, constant: off).isActive = true
        typeL.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    	
    override func layoutSubviews() {
        super.layoutSubviews()
        if let m = self.movie {
            if !m.poster.isEmpty{
                posterIV.image = UIImage.init(named: "Posters/" + m.poster)
            }
            titleL.text = m.title
            if let y = m.year{
                yearL.text = String(y)
            }
            typeL.text = m.type
        }
    }
}
