//
//  AlbumManager.swift
//  CaptureTheMoment
//
//  Created by Doyoung Song on 6/22/20.
//  Copyright © 2020 Doyoung Song. All rights reserved.
//

import UIKit

struct AlbumManager {
    var image: [Data?]
    var comment: [String?]
    var imageTag: [String?]
}

struct Picture {
    var image: Data?
    var comment: String?
    var imageTag: String?
    var thumbnail: Data?
}

var album = [Picture]()
