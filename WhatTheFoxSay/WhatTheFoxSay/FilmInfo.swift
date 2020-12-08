//
//  FilmInfo.swift
//  WhatTheFoxSay
//
//  Created by Lex Torbanov on 07.12.2020.
//

import Foundation
import UIKit

class FilmInfo {
    var title: String
    var year: Int?
    var imdbID: String
    var type: String
    var poster: String

    init(title: String, year: String, imdbID: String, type: String, poster: String){
        self.title = title
        self.year = Int(year)
        self.imdbID = imdbID
        self.type = type
        self.poster = poster
    }
    func toString() -> String{
        return "\(title)  \(String(year ?? 0))  \(imdbID)  \(type)  \(poster)\n"
    }

}
