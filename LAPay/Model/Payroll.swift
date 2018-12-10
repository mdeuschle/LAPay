//
//  Payroll.swift
//  LAPay
//
//  Created by Matt Deuschle on 11/10/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import Foundation

struct Payroll: Codable {
    let average_basic_life: String?
    let average_benefit_cost: String?
    let average_dental_cost: String?
    let average_health_cost: String?
    let base_pay: String?
    let benefits_plan: String?
    let department_title: String?
    let employment_type: String?
    let fms_department: String?
    let hourly_or_event_rate: String?
    let job_class: String?
    let job_class_title: String?
    let longevity_bonus_pay: String?
    let lump_sum_pay: String?
    let mou: String?
    let mou_title: String?
    let other_pay_adjustments: String?
    let overtime_pay: String?
    let pay_grade: String?
    let pay_other_actual: String?
    let payments_over_base_pay: String?
    let payroll_department: String?
    let percent_over_base_pay: String?
    let permanent_bonus_pay: String?
    let projected_annual_salary: String?
    let q1_payments: String?
    let q2_payments: String?
    let q3_payments: String?
    let q4_payments: String?
    let record_number: String?
    let row_id: String?
    let temporary_bonus_pay: String?
    let total_payments: String?
    let year: String?
    let job_class_link: String?
}

typealias PayrollDetail = (title: String, value: String?)

extension Payroll {
    var payrollDetails: [PayrollDetail] {
        return [
            ("Job Class Description", job_class_link),
            ("Calendar Year", year),
            ("Total earnings for the year", total_payments?.dollars),
            ("Base compensation for hours worked", base_pay?.dollars),
            ("Payments attributable to permanent bonuses; typically pensionable", permanent_bonus_pay?.dollars),
            ("Payments attributable to years of service; typically pensionable", longevity_bonus_pay?.dollars),
            ("Payments attributable to temporary bonuses; typically not pensionable", temporary_bonus_pay?.dollars),
            ("Average cost to the City to provide basic life insurance to the employee", average_basic_life?.dollars),
            ("Lump sum payouts for special purposes - retirement payouts, back pay, etc.; typically not pensionable", lump_sum_pay?.dollars),
            ("Payments attributable to hours worked beyond regular work schedule", overtime_pay?.dollars),
            ("Payments based on other pay codes or adjustments that do not fall into another category", other_pay_adjustments?.dollars),
            ("Other Pay includes bonuses, adjustments, and lump sum payouts. Examples of bonuses include Permanent, Longevity, and Temporary Bonuses. Lump Sum Pay includes significant one-time payouts due to retirement, lawsuit settlements, or other adjustments", pay_other_actual?.dollars),
            ("The total average City contribution for the employee's health care, dental care and life insurance", average_benefit_cost?.dollars),
            ("Average cost to the City to provide dental care to the employee", average_dental_cost?.dollars),
            ("Average cost to the City to provide health care to the employee", average_health_cost?.dollars),
            ("Average cost to the City to provide basic life insurance to the employee", average_basic_life?.dollars),
            ("Base Pay", base_pay?.dollars),
            ("Benefits Plan", benefits_plan?.dollars),
            ("Title of City Department", department_title),
            ("Employment Type", employment_type),
            ("FMS Department", fms_department),
            ("Hourly Earnings Rate or Per Event Rate based on Projected Annual Salary", hourly_or_event_rate?.dollars),
            ("Job Class", job_class),
            ("Pay Grade for the Job Class", pay_grade),
            ("Job Class Title", job_class_title),
            ("Longevity Bonus Pay", longevity_bonus_pay?.dollars),
            ("Unique Identifier for each row", row_id),
            ("Department Number in City Payroll System", payroll_department),
            ("Record Number", record_number),
            ("Budgeted pay amount. Used for pension contribution calculations", projected_annual_salary?.dollars),
            ("Payments for the first quarter of the year from January 1 to March 31", q1_payments?.dollars),
            ("Payments for the second quarter of the year from April 1 to June 30", q2_payments?.dollars),
            ("Payments for the third quarter of the year from July 1 to September 30", q3_payments?.dollars),
            ("Payments for the fourth quarter of the year from October 1 to December 31", q4_payments?.dollars),
            ("Payments in excess of Base Pay which may include bonuses and other payouts", payments_over_base_pay?.dollars),
            ("Percentage of payment in excess of Base Pay which may include bonuses and other payouts", percent_over_base_pay?.dollars),
            ("Title of Memorandum of Understanding", mou_title),
            ("Memorandum of Understanding", mou),
            ("Department number in City Financial Management System", fms_department),
        ]
    }
}





