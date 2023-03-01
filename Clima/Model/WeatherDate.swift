import Foundation

struct WeatherDate: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
    let feels_like: Double
}

struct Weather: Decodable {
    let id: Int
}
