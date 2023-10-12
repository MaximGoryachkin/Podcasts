//
//  CTime + String.swift
//  Podcasts
//
//  Created by Максим Горячкин on 12.10.2023.
//

import CoreMedia

extension CMTime {
    func convertToMinutesSeconds() -> String {
        let value = Int(self.seconds)
        let minutes = String(format: "%02d", value / 60)
        let seconds = String(format: "%02d", value % 60)
        return "\(minutes):\(seconds)"
    }
}
