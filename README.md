# Movie App

Welcome to Moview! This is a simple iOS application for viewing a paginated list of Movies with the ability to search by title. Users can also view detailed information about any of the movies.

## Important Notes

- The app only availble for mobile devices in portrait.
- Deployment Info is iOS 15.0.
- A network layer was added to demonstrate scalability, although a simpler solution could have been submitted.
- Theme support is added but I added only one theme due to time constraints.
- Used Swift Catalog for localization.
- Added a simple structure for an analytics tool though it is not integrated but it will showcase how it could be scaled.

## Dependencies

- **Alamofire:** Networking
- **Kinngfisher:** Downloading Images 

## Assumptions

- Analytics tool could be built but maybe not used.
- Multitheme support could be built but not used.

## Tests
- **Unit Tests**: Added tests for Netwrok Layer, Image Provider and Movies List View Model.
- **Maunal Tests**: Manual Testing is conducted to make sure all requirements are met.
- **Memory Leaks Tests**: Memory leaks checks using Instruments(main branch) with zero memory leaks.

## Enhancements To Be Added

- **Separation of Different Error Types (Netwrok - Server -Client)**
- **Response Caching**
- **Better Error State Handling**
- **Better UITests & Unit Testing Coverage**
- **Movies & Genres can have their own Repositories for scalability and testability**
- **Details Screen could have more data and better UI**
- **Add Router for Navigation**

## Technologies Used

- **UIKit**: Movies List Screen & Details Screen

## Screenshots

<img src="https://github.com/user-attachments/assets/89c586e4-16c0-4e72-941c-36242b4d94bd" alt="Screenshot 1" width="300">
<img src="https://github.com/user-attachments/assets/21ad6d15-d00e-407d-8ac6-f8f1b7f51715" alt="Screenshot 2" width="300">
<img src="https://github.com/user-attachments/assets/96e684da-3468-4806-a32f-584c6366898a" alt="Screenshot 3" width="300">
<img src="https://github.com/user-attachments/assets/556c8ae2-7a7d-4bda-a4df-f94ea15e98ec" alt="Screenshot 4" width="300">

## Getting Started

To get started with the project, follow these steps:

1. Clone the repository to your local machine:

```bash
git clone https://github.com/mohamedfarid1993/movie-list
```

2. Go to movie-list folder 

```bash
cd movie-list 
```

3. Open project in Xcode

```bash
open Movie.xcodeproj
```
