//
//  FeaturedPlaylistCell.swift
//  Spotify
//
//  Created by ahmed elmemy on 3/6/20.
//  Copyright © 2020 ElMeMy. All rights reserved.
//

import UIKit
import Kingfisher
class FeaturedPlaylistCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var ownerName: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    var featuredPlaylistCellViewModel:FeaturedPlaylistCellViewModel?
    {
        didSet
        {
            name.text = featuredPlaylistCellViewModel?.name
            ownerName.text = featuredPlaylistCellViewModel?.ownderName
            let url = URL(string: ((featuredPlaylistCellViewModel?.image.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)) ?? ""))
            img.kf.setImage(with: url)
        }
    }
    
}
