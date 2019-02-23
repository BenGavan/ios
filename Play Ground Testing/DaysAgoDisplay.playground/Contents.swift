//: Playground - noun: a place where people can play

import UIKit

let now = Data()
let pastDate = Date(timeIntervalSinceNow: -60 * 62)

extension Date {
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = week * 4
        
        if secondsAgo < minute {
            return "\(secondsAgo) seconds ago"
        } else if secondsAgo < hour {
            return "\(secondsAgo / minute) minutes ago"
        } else if secondsAgo < day {
            return "\(secondsAgo / hour) hours ago"
        } else if secondsAgo < week {
            return "\(secondsAgo / day) Days ago"
        }
        
        return "\(secondsAgo / week) Weaks ago"
    }
}

pastDate.timeAgoDisplay()