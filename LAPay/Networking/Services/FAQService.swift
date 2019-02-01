//
//  FAQService.swift
//  LAPay
//
//  Created by Matt Deuschle on 1/23/19.
//  Copyright © 2019 Matt Deuschle. All rights reserved.
//

import Foundation

struct FAQService {
    static let shared = FAQService()
    private init() {}
    var all = [
        FAQ(question: "What vesion of LAPay am I using? This is extra data to test the length of the question",
            answer: "You are using version 1.0. How much does it matter that this is a long text"),
    ]
    
}
