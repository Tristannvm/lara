//
//  getbmhash.swift
//  lara
//
//  Created by ruter on 12.05.26.
//

import Foundation

func getbmhash() -> String? {
    let path = "/private/preboot"
    let fm = FileManager.default

    let regex = try! NSRegularExpression(pattern: "^[A-Fa-f0-9]{64,128}$")

    guard let enumerator = fm.enumerator(atPath: path) else { return nil }

    for case let file as String in enumerator {
        let full = (path as NSString).appendingPathComponent(file)

        guard let content = try? String(contentsOfFile: full) else {
            continue
        }

        let lines = content.split(whereSeparator: \.isNewline)

        for line in lines {
            let range = NSRange(line.startIndex..<line.endIndex, in: line)

            if regex.firstMatch(in: String(line), range: range) != nil {
                return String(line)
            }
        }
    }

    return nil
}
