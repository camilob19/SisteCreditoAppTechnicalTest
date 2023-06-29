//
//  String.swift
//  VideogameApp
//
//  Created by Cristian on 29/06/23.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self,
                                 tableName: "GeneralStrings",
                                 bundle: .main,
                                 value: self,
                                 comment: self)
    }
}
