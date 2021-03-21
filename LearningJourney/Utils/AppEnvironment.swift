import SwiftUI

protocol AppEnvironment: AnyObject {
    var screenSize: CGSize { get }
}

final class DefaultAppEnvironment: AppEnvironment {
    var screenSize: CGSize { UIScreen.main.bounds.size }
}


private struct AppEnvironmentKey: EnvironmentKey {
    static var defaultValue: AppEnvironment = DefaultAppEnvironment()
}

extension EnvironmentValues {
    var appEnvironment: AppEnvironment {
        get { self[AppEnvironmentKey.self] }
        set { self[AppEnvironmentKey.self] = newValue }
    }
}
