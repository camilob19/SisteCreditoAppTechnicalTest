//
//  DateFormatterHelper.swift
//  VideogameApp
//
//  Created by Cristian Camilo Betancourt  on 28/06/23.
//

import Foundation

enum DateFormat: String {
    // 2020-03-10
    case serverFormat = "yyyy-MM-dd"
}

extension String {
    func date(using format: DateFormat) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.date(from: self)
    }
}
