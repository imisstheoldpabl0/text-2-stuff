import Foundation

enum Config {
    #if targetEnvironment(simulator)
    static let apiBaseURL = "http://localhost:3000/api"
    #else
    static let apiBaseURL = "http://192.168.1.37:3000/api"
    #endif
}
