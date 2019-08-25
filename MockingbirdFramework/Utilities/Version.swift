//
//  Version.swift
//  MockingbirdShared
//
//  Created by Andrew Chang on 8/23/19.
//  Copyright © 2019 Bird Rides, Inc. All rights reserved.
//

import Foundation

/// Swift Package Manager doesn't create an Info.plist section in the binary like xcodebuild.
let mockingbirdVersion = Version(semver: [0, 1, 0])

struct Version: Comparable {
  let semver: [Int]
  var shortString: String { return semver.map({ "\($0)" }).joined(separator: ".") }
  
  init(semver: [Int]) {
    self.semver = semver
  }
  
  init(shortString: String) {
    self.init(semver: shortString.components(separatedBy: ".").map({ Int($0) ?? 0 }))
  }
  
  static func < (lhs: Version, rhs: Version) -> Bool {
    for i in 0..<min(lhs.semver.count, rhs.semver.count) {
      if lhs.semver[i] < rhs.semver[i] { return true }
    }
    return lhs.semver.count < rhs.semver.count
  }
  
  static func << (lhs: Version, rhs: Version) -> Bool {
    return lhs.semver.first ?? 0 < rhs.semver.first ?? 0
  }
}
