# Weather App

A Flutter-based weather application that provides current weather information, including temperature, humidity, and wind speed. Users can search for weather data by city, and the app displays appropriate animations based on the weather conditions.

## Features
- Displays current weather: temperature, humidity, and wind speed
- Allows users to search for weather by city
- Dynamic animation based on weather conditions (rainy, cloudy, etc.)


## Installation and Setup

Follow these steps to set up and run the Weather App:

### Prerequisites
- Ensure you have [Flutter](https://flutter.dev/docs/get-started/install) installed on your machine.
- An IDE such as [Visual Studio Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio).

### Clone the Repository
```bash
git clone https://github.com/BalajiReddy1/weather-app.git
cd weather-app
```

### Install Dependencies
``` flutter pub get ```

### Configure API Key
- Obtain Obtain an API key from [OpenWeatherMap](https://openweathermap.org/)
- Add your API key to the weather_screen.dart file in the apiKey constant:
  - const apiKey = 'YOUR_API_KEY_HERE';

### Run the application
- flutter run


