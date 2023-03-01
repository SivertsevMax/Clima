import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=fd79f2376e9c3bfd5946c9200e21dc98&&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeDate = data {
                    self.parseJSON(weatherDate: safeDate)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(weatherDate: Data) {
        let decodec = JSONDecoder()
        do {
            let decodedDate = try decodec.decode(WeatherDate.self, from: weatherDate)
            let id = decodedDate.weather[0].id
            let cityName = decodedDate.name
            let temp = decodedDate.main.temp
            
            let weather = WeatherModel(conditionId: id, cityName: cityName, temperature: temp)
        } catch {
            print("This city doesn't exist\n  \(error)")
        }
    }
    

}
