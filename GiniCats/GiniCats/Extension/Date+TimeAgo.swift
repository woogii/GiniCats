//
//  Date+TimeAgo.swift
//  GiniCats
//
//  Created by siwook on 2017. 10. 15..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK: - Date Extension
extension Date {
  func timeAgoDisplay() -> String {
    let secondsAgo = Int(Date().timeIntervalSince(self))
    let minute = 60
    let hour = 60 * minute
    let day = 24 * hour
    let week = 7 * day
    if secondsAgo < minute {
      return "\(secondsAgo)" + Constants.SecondsAgo
    } else if secondsAgo < hour {
      return "\(secondsAgo/minute)" + Constants.MinutesAgo
    } else if secondsAgo < day {
      return "\(secondsAgo/hour)" + Constants.HoursAgo
    } else if secondsAgo < week {
      return "\(secondsAgo/day)" + Constants.DaysAgo
    }
    return "\(secondsAgo/week)" + Constants.WeeksAgo
  }
}
