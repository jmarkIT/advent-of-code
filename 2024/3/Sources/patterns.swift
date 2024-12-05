//
//  pattern.swift
//  Mull It Over
//
//  Created by James Mark on 12/4/24.
//

import Foundation
import RegexBuilder

let search = Regex {
    "mul("
    Capture {
        OneOrMore(.digit)
    } transform: {
        Int($0)
    }
    ","
    Capture {
        OneOrMore(.digit)
    } transform: {
        Int($0)
    }
    ")"
}

let doSearch = Regex {
    
}
