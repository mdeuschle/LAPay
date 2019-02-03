//
//  FAQService.swift
//  LAPay
//
//  Created by Matt Deuschle on 1/23/19.
//  Copyright © 2019 Matt Deuschle. All rights reserved.
//

import Foundation

struct FAQService {
    let year: String
    func getFAQs() -> [FAQ] {
        return [
            FAQ(question: "Which version of LAPay am I using?",
                answer: "You are using version 1.0."),
            FAQ(question: "How recent is this data?",
                answer: "This data is for the year \(year)"),
            FAQ(question: "How do I search?",
                answer: "Pull down to reveal the search bar."),
            FAQ(question: "How many jobs are listed in LAPay?",
                answer: "Due to the size of of the complete JSON file, I limited the job listings to 25k, making over $80k."),
            FAQ(question: "Do I need Wi-Fi or a signal to use LAPay?",
                answer: "Just the first time, after that, LAPay cache's the data."),
            FAQ(question: "Do I need an account to use LAPay?",
                answer: "No."),
            FAQ(question: "Does LAPay track, collect, share, or sell any of my data?",
                answer: "No."),
            FAQ(question: "Where does LAPay get its data?",
                answer: "https://controllerdata.lacity.org/"),
            FAQ(question: "So what exactly does the data represent?",
                answer: "From above: \"Payroll information for all Los Angeles City Employees including the City's three proprietary departments: Water and Power, Airports and Harbor. Data is updated on a quarterly basis by the Los Angeles City Controller's Office. Payroll information for employees of the Department of Water and Power is provided by the Department.\""),
            FAQ(question: "According to the job descriptions, I have the same job, but I don't make anywhere near this. What's up with that?",
                answer: "Good question."),
            FAQ(question: "Whenever I try to reach a city employee after 4:00pm, they have all left for the day. Where is all of this overtime coming from?",
                answer: "Another good question."),
            FAQ(question: "These salaries are outrageous. Especially the DWP. I'm working my a$$ off to pay for my mortgage, insurance, school, and food. As a Los Angeles taxpayer, I'm sickened. This is wrong. I'm going to do something about this.",
                answer: "Please do."),
            FAQ(question: "Why did you make this app? It's free and there are no ads.",
                answer: "See above."),
            FAQ(question: "How do I contact you?",
                answer: "mattmobileapps@gmail.com"),
            FAQ(question: "What's your privacy policy?",
            answer: "https://sites.google.com/view/lapay/privacy-policy?authuser=0")
        ]
    }
    
}
