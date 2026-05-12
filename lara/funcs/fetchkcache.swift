//
//  fetchkcache.swift
//  lara
//
//  Created by ruter on 12.05.26.
//

import Foundation

func getkcachepath() -> String? {
    guard let hash = getbmhash() else { return nil }
    return "/private/preboot/\(hash)/System/Library/Caches/com.apple.kernelcaches/kernelcache"
}

func kcpath() -> URL? {
    let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    guard let docs = urls.first else { return nil }
    return docs.appendingPathComponent("kernelcache")

}

func fetchkcache() -> Bool {
    guard
        let srcpath = getkcachepath(),
        let srcurl = URL(string: "file://\(srcpath)"),
        let dest = kcpath()
    else {
        return false
    }

    let fm = FileManager.default

    do {
        if fm.fileExists(atPath: dest.path) {
            try fm.removeItem(at: dest)
        }

        try fm.copyItem(at: srcurl, to: dest)

        guard resolvekernoffsets(dest.path) else {
            return false
        }

        globallogger.log("(fetchkcache) success!")
        return true

    } catch {
        return false
    }
}
