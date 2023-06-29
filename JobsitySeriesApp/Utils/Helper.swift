//
//  Helper.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 29/06/23.
//

import Foundation

class Helper{
    static func checkEmptySchedules(schedule: ScheduleResponse?) -> Schedule {
        var time: String = schedule?.time ?? ""
        var days: [String] = schedule?.days ?? []
        
        if time.isEmpty { time = "-" }
        if days.isEmpty { days = ["-"] }
        
        return Schedule(time: time, days: days)
    }
    
    static func checkEmptyRating(rating: Double?) -> String {
        if let ratingResponse = rating {
            return String(ratingResponse)
        }
        return "-"
    }
}
