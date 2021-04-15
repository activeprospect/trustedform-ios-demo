//
//  String+localized.swift
//  TrustedForm_Demo
//
//  Created by Konrad Siemczyk on 05/01/2021.
//  Copyright © 2021 Devscale. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
