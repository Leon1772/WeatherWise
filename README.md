# WeatherWise 🌤️

A sleek, pixel-art inspired weather application that provides real-time weather information with a unique visual style.

## Features

- **Real-time Weather Data**: Get current weather conditions for major Chinese cities
- **Pixel Art Design**: Retro-inspired UI with pixel-perfect aesthetics and animated weather icons
- **Smart Caching**: Local storage for faster loading and reduced API calls
- **Weather Trends**: View temperature trends with a pixel-style chart
- **Optimized Performance**: Loads in under 1 second with cached data
- **Resilient Icon System**: Multi-layered fallback system for weather icons

## Weather Icons

We use Animated SVG Weather Icons from [basmilius/weather-icons](https://github.com/basmilius/weather-icons). To prevent losing these icons:

1. The icons are stored locally in `/assets/weather-icons/`
2. Each icon is optimized for performance
3. Backup repository: [Weather Icons Backup](https://github.com/basmilius/weather-icons/archive/refs/heads/master.zip)
4. Automatic fallback to CDN if local icons are unavailable
5. In-memory caching for instant loading
6. Local storage backup for offline access

### Icon Usage

```javascript
// Example of how we use the weather icons
const iconPath = `/assets/weather-icons/${weatherCode}.svg`;
```

## Quick Start

1. Clone the repository:
   ```bash
   git clone https://github.com/Leon1772/WeatherWise.git
   ```

2. Open `index.html` in your web browser

3. No installation required - it's a pure frontend application!

## Cities Available

Currently supporting three major Chinese cities:
- Beijing (北京)
- Shanghai (上海)
- Shenzhen (深圳)

## Technical Details

- **API**: OpenWeather API for real-time weather data
- **Caching**: 5-minute cache duration for optimal performance
- **Chart Library**: Chart.js with pixel art styling
- **Icons**: SVG-based animated weather icons
- **Storage**: Local storage for data persistence

## Performance Optimizations

1. **Caching Strategy**:
   - Weather data cached for 5 minutes
   - Immediate display of cached data
   - Background updates for fresh data

2. **Resource Loading**:
   - Preloaded weather icons
   - Optimized SVG animations
   - Minimal API calls

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Live Demo

Check out the live version at: [WeatherWise on GitHub Pages](https://leon1772.github.io/WeatherWise/)

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Author

- **Leon** - [GitHub](https://github.com/Leon1772)

## Acknowledgments

- Weather icons by [Bas Milius](https://github.com/basmilius/weather-icons)
- OpenWeather API for weather data
- Chart.js for trend visualization

## Usage

- Select a city from the dropdown menu
- View current weather conditions
- Check the temperature trend chart
- Switch between weekly and monthly views

## API Key

This project uses the OpenWeather API. To use your own API key:

1. Sign up at [OpenWeather](https://openweathermap.org/api)
2. Replace the API key in `preview.html`:
   ```javascript
   const API_KEY = 'YOUR_API_KEY';
   ```

## Screenshots

![WeatherWise Screenshot](screenshot.png) 