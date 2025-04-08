// Weather Icon Manager
class WeatherIconManager {
    constructor() {
        this.iconCache = new Map();
        this.baseUrl = '/assets/weather-icons/';
        this.fallbackUrl = 'https://raw.githubusercontent.com/basmilius/weather-icons/master/production/fill/svg/';
        this.weatherConditions = {
            'clear-day': ['01d'],
            'clear-night': ['01n'],
            'partly-cloudy-day': ['02d', '03d'],
            'partly-cloudy-night': ['02n', '03n'],
            'cloudy': ['04d', '04n'],
            'rain': ['09d', '09n', '10d', '10n'],
            'thunderstorm': ['11d', '11n'],
            'snow': ['13d', '13n'],
            'mist': ['50d', '50n']
        };
    }

    async getIcon(weatherCode) {
        const iconName = this.getIconName(weatherCode);
        
        // Check cache first
        if (this.iconCache.has(iconName)) {
            return this.iconCache.get(iconName);
        }

        try {
            // Try local first
            const localIcon = await this.fetchIcon(`${this.baseUrl}${iconName}.svg`);
            this.iconCache.set(iconName, localIcon);
            return localIcon;
        } catch (error) {
            console.log('Local icon not found, trying fallback...');
            try {
                // Try fallback
                const fallbackIcon = await this.fetchIcon(`${this.fallbackUrl}${iconName}.svg`);
                this.iconCache.set(iconName, fallbackIcon);
                // Save to local storage for future use
                this.saveIconToLocal(iconName, fallbackIcon);
                return fallbackIcon;
            } catch (fallbackError) {
                console.error('Failed to load icon:', fallbackError);
                return this.getDefaultIcon();
            }
        }
    }

    getIconName(weatherCode) {
        for (const [name, codes] of Object.entries(this.weatherConditions)) {
            if (codes.includes(weatherCode)) {
                return name;
            }
        }
        return 'clear-day'; // Default icon
    }

    async fetchIcon(url) {
        const response = await fetch(url);
        if (!response.ok) throw new Error(`Failed to fetch icon: ${url}`);
        return await response.text();
    }

    saveIconToLocal(name, svg) {
        try {
            localStorage.setItem(`weather-icon-${name}`, svg);
        } catch (error) {
            console.warn('Failed to save icon to local storage:', error);
        }
    }

    getDefaultIcon() {
        // Simple default SVG icon
        return `<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <circle cx="12" cy="12" r="5" fill="currentColor"/>
        </svg>`;
    }
}

// Export the manager
window.weatherIconManager = new WeatherIconManager(); 