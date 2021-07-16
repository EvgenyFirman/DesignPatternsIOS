//
//  LibraryAPI.swift
//  RWBlueLibrary
//
//  Created by Евгений Фирман on 15.07.2021.
//  Copyright © 2021 Razeware LLC. All rights reserved.
//

import Foundation

final class libraryAPI {
  static let shared = libraryAPI()
  
  private let persistencyManager = PersistencyManager()
  
  private let httpClient = HTTPClient()
  
  private let isOnline = false
  
  func getAlbums() -> [Album] {
    
    return persistencyManager.getAlbums()
    
  }
  
  func addAlbum(_ album: Album, at index: Int) {
    persistencyManager.addAlbum(album, at: index)
    if isOnline {
      httpClient.postRequest("/api/addAlbum", body: album.description)
    }
  }
  
  func deleteAlbum(at index: Int) {
    persistencyManager.deleteAlbum(at: index)
    if isOnline {
      httpClient.postRequest("/api/deleteAlbum", body: "\(index)")
    }
  }
  
  private init(){
    
  }
}

