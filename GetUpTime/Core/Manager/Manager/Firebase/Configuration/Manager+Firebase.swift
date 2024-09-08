//
//  Manager+Firebase.swift
//  GetUp
//
//  Created by Rodrigo Souza on 05/09/24.
//

import Dependencies

extension Manager {
    struct Firebase {
        public var configure: @Sendable () -> Void
    }
}

extension Manager.Firebase: DependencyKey {
    public static let liveValue = Self(
        configure: {  }
    )
}

extension Manager.Firebase: TestDependencyKey {
    public static let previewValue = Self.noop
    
    public static let testValue = Self(
        configure: unimplemented("\(Self.self).configure")
    )
}

extension Manager.Firebase {
    static let noop = Self(
        configure: {}
    )
}
