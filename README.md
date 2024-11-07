# Movie Collector App

## Overview
The Movie Collector App is a Flutter-based application that allows users to search for movies, view detailed information, and save favorite films for later reference. The app leverages the [OMDb API](http://www.omdbapi.com/) to fetch movie data, including titles, ratings, plot summaries, and more. This project uses the **Bloc pattern** to manage state and ensure smooth, reactive UI updates.

## Getting Started

### Instructions to Run the App

1. **Clone the Repository:**
    ```bash
    git clone https://github.com/Yash-Sewp/movie-collector
    cd movie_collector_app
    ```

2. **Set up API key:**
    - Create a `.env` file in the root directory.
    - Add your OMDb API key to the `.env` file:
      ```bash
      API_KEY=your_omdb_api_key
      ```

3. **Install Dependencies:**
    ```bash
    flutter pub get
    ```

4. **Unit Testing:**
   Run unit tests to ensure everything is working:
    ```bash
    flutter test
    ```

5. **Run Application:**
   Launch the app on your preferred device/emulator:
    ```bash
    flutter run
    ```

## Third-Party Packages

This project uses the following third-party packages:

- **flutter_bloc**: For state management using the Bloc pattern.
- **http**: To make API requests to the OMDb API and fetch movie data.
- **flutter_dotenv**: For securely storing and accessing environment variables like the API key.
- **mocktail**: For writing unit tests with mock objects, especially useful for testing the Bloc logic.
- **bloc_test**: For writing unit tests for Bloc components and ensuring state management works as expected.

## Assumptions

- The app assumes that the user has a valid **OMDb API key**, as this is required to fetch movie data.
- The **Bloc pattern** was chosen for state management to separate business logic from the UI, making the app more scalable and testable.

## Potential Improvements

- **Favorites & Watchlist**: Enable users to save their favorite movies and build a watchlist for future viewing.
- **User Authentication**: Allow users to create accounts and store data to the cloud for a personalized experience.
- **Enhanced Search**: Add advanced filtering options, such as by genre, release year, or rating, to improve search functionality.

---
