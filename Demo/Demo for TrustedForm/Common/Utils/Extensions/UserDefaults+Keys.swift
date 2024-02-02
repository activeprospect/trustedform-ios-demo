import class Foundation.UserDefaults

extension UserDefaults {
    @UserDefault(key: "hasSeenIntro", defaultValue: false)
    static var hasSeenIntro: Bool
}
