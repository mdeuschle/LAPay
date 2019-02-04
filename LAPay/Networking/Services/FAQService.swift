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
                answer: "This data is for the year \(year)."),
            FAQ(question: "How do I search?",
                answer: "Pull down to reveal the search bar."),
            FAQ(question: "How many jobs are listed in LAPay?",
                answer: "It's a big JSON file. I limited the job listings to 25k, making over $80k, for better performance."),
            FAQ(question: "Do I need Wi-Fi or a signal to use LAPay?",
                answer: "Just the first time. After that, LAPay cache's the data."),
            FAQ(question: "Do I need an account to use LAPay?",
                answer: "No."),
            FAQ(question: "Does LAPay track, collect, share, or sell any of my data?",
                answer: "No."),
            FAQ(question: "Where does LAPay get its data?",
                answer: "https://controllerdata.lacity.org/"),
            FAQ(question: "So what exactly does the data represent?",
                answer: "From above: \"Payroll information for all Los Angeles City Employees including the City's three proprietary departments: Water and Power, Airports and Harbor. Data is updated on a quarterly basis by the Los Angeles City Controller's Office. Payroll information for employees of the Department of Water and Power is provided by the Department.\""),
            FAQ(question: "According to the job description, I have the same job. But I don't make anywhere near this. What's up with that?",
                answer: "Good question."),
            FAQ(question: "Where is all of this overtime coming from? Whenever I try to reach an LA City employee after 4:00pm, everyone is gone for the day.",
                answer: "Another good question."),
            FAQ(question: "I live in LA. I understand LA is expensive and I have to pay taxes, but these salaries are unreasonable. I'm going to do something about this.",
                answer: "Please do."),
            FAQ(question: "Why did you make this app? It's free and there are no ads.",
                answer: "See above."),
            FAQ(question: "How can I contact you?",
                answer: "mattmobileapps@gmail.com"),
            FAQ(question: "What's your privacy policy?",
            answer: "https://sites.google.com/view/lapay/privacy-policy?authuser=0")
        ]
    }
    
}
