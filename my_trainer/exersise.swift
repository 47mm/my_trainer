//
//  exersise.swift
//  my_trainer
//
//  Created by  Kirill Berezin on 06.04.2020.
//  Copyright © 2020  Kirill Berezin. All rights reserved.
//

import Foundation

class exersise {
    var name: String;
    var duration: Int;
    var rest: Int;
    init(name: String, duration: Int, rest: Int) {
        self.name = name
        self.duration = duration
        self.rest = rest
    }
}
