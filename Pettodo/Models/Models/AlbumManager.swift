//
//  AlbumManager.swift
//  Pettodo
//
//  Created by 최민경 on 2023/09/18.
//

import Foundation
import UIKit

final class AlbumManager {
    
    // 저장 배열
    var albumList:[Album] = []
    
    
    func makeAlbumsListDatas() {
    albumList = [
//    Album(image: UIImage(named: "pet2"), date: "2023.11.04", contents: "귀엽다ㅎㅎ", emoji: "🥰"),
//    Album(image: UIImage(named: "pet1"), date: "2023.11.10", contents: "고양이 너무 귀여워요", emoji: "🐱")
    ]
    }
    
    
    func getAlbumList() -> [Album] {
        return albumList
    }
    
    func makeNewAlbum(_ album: Album ){
        albumList.append(album)
    }
    
    // 기존 앨범 정보 업데이트
    func updateAlbumInfo(index: Int, _ album: Album) {
        albumList[index] = album
    }
   
}
