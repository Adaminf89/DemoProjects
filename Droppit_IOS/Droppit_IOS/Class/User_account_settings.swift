//
//  File.swift
//  Droppit_IOS
//
//  Created by Adam Infiesto on 11/12/18.
//  Copyright © 2018 Adam Infiesto. All rights reserved.
//

import Foundation
class UserAccountSetting : NSObject
{
    var desc: String
    var display_name: String
    var profile_photo: String
    var user_id : String
    var username : String
    
    init(desc : String, display_name: String,
                  profile_photo: String,
                  user_id : String, username: String )
    {
        self.desc = desc
        self.display_name = display_name
        self.profile_photo = profile_photo
        self.user_id = user_id
        self.username = username
    }
    
}
