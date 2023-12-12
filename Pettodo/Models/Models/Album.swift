//
//  Album.swift
//  Pettodo
//
//  Created by 최민경 on 2023/09/18.
//

import UIKit


struct Album {
    var image: UIImage?
    var date: String?
    var contents: String?
    var emoji: String?
    
    init(image: UIImage?, date: String?, contents: String?, emoji: String?) {
//    init(date: String?, contents: String?, emoji: String?) {
        self.image = image
        self.date = date
        self.contents = contents
        self.emoji = emoji
    }
}
