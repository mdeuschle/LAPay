//
//  Payroll.swift
//  LAPay
//
//  Created by Matt Deuschle on 11/10/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import Foundation

struct Payroll: Codable {
    let hourly_or_event_rate: String?
    let payments_over_base_pay: String?
    let employment_type: String?
    let mou_title: String?
    let fms_department: String?
    let year: String?
    let record_number: String?
    let average_basic_life: String?
    let total_payments: String?
    let q3_payments: String?
    let temporary_bonus_pay: String?
    let payroll_department: String?
    let average_benefit_cost: String?
    let benefits_plan: String?
    let q2_payments: String?
    let pay_grade: String?
    let mou: String?
    let base_pay: String?
    let department_title: String?
    let projected_annual_salary: String?
    let other_pay_adjustments: String?
    let lump_sum_pay: String?
    let overtime_pay: String?
    let pay_other_actual: String?
    let percent_over_base_pay: String?
    let q4_payments: String?
    let average_health_cost: String?
    let permanent_bonus_pay: String?
    let job_class: String?
    let average_dental_cost: String?
    let longevity_bonus_pay: String?
    let job_class_title: String?
    let q1_payments: String?
    let job_class_link: JobClassLink?
}

struct JobClassLink: Codable {
    let url: String
}



