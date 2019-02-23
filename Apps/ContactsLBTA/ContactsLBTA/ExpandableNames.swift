//
//  ExpandableNames.swift
//  ContactsLBTA
//
//  Created by Ben Gavan on 30/11/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import Foundation
import Contacts

struct ExpandableNames {
    var isExpanded: Bool
    var names: [FavoritableContact]
}

struct FavoritableContact {
    let contact: CNContact
    var hasFavorited: Bool
}
