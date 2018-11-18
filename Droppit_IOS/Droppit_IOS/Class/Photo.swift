//
//  Photo.swift
//  Droppit_IOS
//
//  Created by Adam Infiesto on 11/11/18.
//  Copyright © 2018 Adam Infiesto. All rights reserved.
//

import Foundation

class Photo : NSObject
{
    var caption : String;
    var date_created : String
    var image_path : String
    var location : String
    var locationlong : String
    var mPrivate : String
    var tags : String
    var user_id : String
    
    init(caption : String, date_created : String,
                  image_path : String, location : String,
                  locationlong : String, mPrivate : String,
                  tags : String, user_id : String)
    {
        self.caption = caption
        self.date_created = date_created
        self.image_path = image_path
        self.location = location
        self.locationlong = locationlong
        self.mPrivate = mPrivate
        self.tags = tags
        self.user_id = user_id
    }
    
}
