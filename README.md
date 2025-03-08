# StudySphere: Empowering Students to Discover the Perfect Study Spot

Welcome to **StudySphere**—an innovative mobile application designed to help university students easily discover, evaluate, and select their ideal study spaces. By consolidating location details (e.g., capacity, availability, hours of operation, and more) into a single interactive platform, **StudySphere** addresses a critical student need: reducing time spent searching for study spots and maximizing time spent actually studying.

---

## Table of Contents

1. [Overview](#overview)  
2. [Key Features](#key-features)  
3. [Installation and Setup](#installation-and-setup)  
4. [Usage](#usage)  
5. [User Flow](#user-flow)  
6. [Technical Architecture](#technical-architecture)  
7. [Data Collection & Insights](#data-collection--insights)  
8. [Future Enhancements](#future-enhancements)  
9. [Contributing](#contributing)  
10. [License](#license)
11. [Acknowledgments](#acknowledgments)

---

## Overview

**StudySphere** emerged from an extensive investigation into the study habits of university students, particularly at institutions with dense student populations and numerous but underutilized study venues. Through **questionnaires**, **interviews**, and **field studies**, our team uncovered the following recurring challenges:

- Many students default to a handful of well-known (and therefore crowded) campus libraries.
- Students rely heavily on **word-of-mouth** recommendations when choosing a study location.
- Overcrowding leads to frustration, lack of seating, and wasted time.
- Quiet, comfortable environments with key amenities (e.g., power outlets, proximity to food/drinks) are top priorities for most learners.

By synthesizing this research, the **StudySphere** team established a clear mission:  
> *To create a centralized application that helps students discover new study spots, filter by the factors that matter to them, and receive real-time information about seat availability.*

---

## Key Features

1. **Personalized Recommendations**  
   - Tailored suggestions based on criteria such as outlet availability, lighting preferences, distance from campus, and capacity needs.  
   - Filtering ensures users only see locations aligned with their exact preferences (e.g., quiet vs. collaborative spaces).

2. **Real-Time Capacity Tracking**  
   - Keeps students informed about how crowded a location is in the moment.  
   - Mitigates the frustration of going across campus only to find a full library.

3. **Social/Peer Recommendations**  
   - Users can rate or recommend specific spots.  
   - Encourages a sense of community by allowing users to see where classmates or friends prefer to study.

4. **Comprehensive Spot Details**  
   - Includes hours of operation, addresses, directions, and special amenities (e.g., microwaves, campus cafés).  
   - Quick-glance metrics: noise level, table size, availability of power outlets, presence of natural light, and more.

5. **Map and List Views**  
   - **Map View** pinpoints each study spot's location, aiding quick navigation.  
   - **List View** offers a sortable directory of spaces by distance, rating, or capacity.

6. **Reservation System (Proposed)**  
   - Potential in future iterations: reserve individual seats or group study rooms in-app.  
   - Minimizes time spent wandering through halls to find a suitable table or group-friendly area.

---

## Installation and Setup

> **Note**: StudySphere is a cross-platform mobile application built with Flutter.

1. **Prerequisites**
   - Flutter SDK (version 3.0+)
   - Dart (version 2.17+)
   - Android Studio / Xcode for emulators
   - Firebase project setup
   - Node.js (version 14+) for backend

2. **Clone the Repository & Install Dependencies**

    ```bash
    git clone https://github.com/jaffarkeikei/StudySphere.git  
    cd StudySphere  
    flutter pub get
    ```

3. **Configure Environment Variables**  
   - Create a `.env` file in the project root
   - Add the following keys:
     ```
     API_BASE_URL=your_backend_url
     GOOGLE_MAPS_API_KEY=your_maps_api_key
     FIREBASE_PROJECT_ID=your_firebase_project_id
     ```
   - For the backend, create a separate `.env` file with database credentials

4. **Firebase Setup**
   - Download your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Place these files in the appropriate directories:
     - Android: `android/app/`
     - iOS: `ios/Runner/`

5. **Run the Application**  
   - Start the emulator or connect a physical device
   - Run the app:

     ```bash
     flutter run
     ```

   - For backend development:
     ```bash
     cd backend
     npm install
     npm run dev
     ```

6. **Build for Production**
   ```bash
   flutter build apk --release  # Android
   flutter build ios --release  # iOS
   ```

---

## Usage

1. **Create an Account / Log In**  
   - Users can create accounts using their university email or social logins.

2. **Set Your Preferences**  
   - Choose how far you're willing to walk or commute, your noise-level tolerance, preference for group vs. individual seating, etc.  
   - The app saves these preferences for future recommendations.

3. **Browse Study Spots**  
   - View suggested or popular spots based on your settings.  
   - Sort results by rating, distance, or capacity.

4. **Filter & Refine**  
   - Apply dynamic filters (e.g., *"Must have power outlets,"* *"Open 24 hours,"* *"Has a café nearby"*).

5. **Check Real-Time Status**  
   - Quickly see if a spot is near capacity.  
   - Decide whether to head there immediately or choose another location.

6. **Leave Recommendations**  
   - Submit a short comment on your experience.  
   - Rate how quiet or group-friendly the space was.

7. **(Optional) Reserve a Seat**  
   - Where supported, select a seat or group study room in advance.

---

## User Flow

Below is a simplified flowchart of how a typical user might interact with **StudySphere**:

1. **Home Screen**  
   - Overview of recommended and trending study locations (displayed in both list and map formats).

2. **Spot Search / Filter**  
   - The user applies filters (e.g., location type, capacity) to narrow down the options.

3. **Study Spot Details**  
   - Selecting a spot reveals detailed information: photos, user ratings, operating hours, and nearby amenities.

4. **Check or Reserve**  
   - Users decide whether to visit the spot immediately or reserve a seat (if supported).

5. **Feedback**  
   - After their study session, users can leave reviews to help improve future recommendations.

---

## Technical Architecture

StudySphere follows a modern, scalable architecture designed for mobile-first implementation with robust backend services. The architecture prioritizes performance, security, and real-time data synchronization.

### Architecture Diagram

```
+----------------------------------------------------------------------------------------------------------+
|                                      STUDYSPHERE ARCHITECTURE                                            |
+----------------------------------------------------------------------------------------------------------+

+------------------+      +-------------------+      +-------------------+      +--------------------+
|  CLIENT DEVICES  |      |      MOBILE UI    |      |    CLIENT-SIDE    |      |   LOCAL STORAGE    |
|                  |      |                   |      |      LOGIC        |      |                    |
|  +------------+  |      |  +-----------+    |      |  +------------+   |      |  +-------------+   |
|  | iOS Device |<--------->| Flutter UI |<---------->| State Mgmt. |<--------->|  |Offline Cache|   |
|  +------------+  |      |  +-----------+    |      |  | (Provider) |   |      |  +-------------+   |
|                  |      |                   |      |  +------------+   |      |                    |
|  +------------+  |      |  +-----------+    |      |                   |      |                    |
|  |   Android  |<--------->|  Widgets   |    |      |                   |      |                    |
|  +------------+  |      |  +-----------+    |      |                   |      |                    |
+--------^---------+      +---------^---------+      +---------^---------+      +--------------------+
         |                          |                          |
         |                          |                          |
         |           +-----------------------------------------------------------------------------------+
         |           |                           COMMUNICATION LAYER                                     |
         +-----------+                 REST API, WebSockets, Push Notifications                          |
                     +-------------------------^------------------------^---------------------------^----+
                                               |                        |                           |
+------------------------------------+         |                        |                           |
|        EXTERNAL INTEGRATIONS       |         |                        |                           |
|                                    |         |                        |                           |
|  +-------------+  +-------------+  |         |                        |                           |
|  | Google Maps |  | University  |  |<--------+                        |                           |
|  |    API      |  |    SSO      |  |                                  |                           |
|  +-------------+  +-------------+  |                                  |                           |
|                                    |                                  |                           |
|  +-------------+  +-------------+  |                                  |                           |
|  |  Payment    |  |    Push     |  |<-------------------------+       |                           |
|  |  Gateway    |  | Notification|  |                          |       |                           |
|  +-------------+  +-------------+  |                          |       |                           |
+------------------------------------+                          |       |                           |
                                                                |       |                           |
                                                                |       |                           |
+---------------------------------------+    +----------------------------------------+    +------------------------+
|           BACKEND SERVICES            |    |        REAL-TIME OCCUPANCY SYSTEM      |    |       DATA LAYER       |
|                                       |    |                                        |    |                        |
|  +----------------+  +-------------+  |    |  +------------------+  +------------+  |    |  +------------------+  |
|  |  API Gateway   |<-|   Auth      |  |    |  | WebSocket Server |<-| Occupancy  |  |    |  |     MongoDB      |  |
|  |                |  |  Service    |  |    |  |                  |  | Processor  |  |    |  | (User Profiles,  |  |
|  +-------^--------+  +-------------+  |    |  +------------------+  +------------+  |    |  |  Study Spots,    |  |
|          |                            |    |           ^                  ^         |    |  |    Reviews)      |  |
|          |           +-------------+  |    |           |                  |         |    |  +------------------+  |
|          +---------->| Study Spot  |  |    |           |                  |         |    |                        |
|                      |  Service    |  |    |           |                  |         |    |  +------------------+  |
|                      +------^------+  |    |           |                  |         |    |  |      Redis       |  |
|                             |         |    |           |                  |         |    |  | (Real-time data, |  |
|                      +------+------+  |    |           |                  |         |    |  |    Caching)      |  |
|                      | Analytics   |  |    |           |                  |         |    |  +------------------+  |
|                      |  Service    |  |    |           |                  |         |    |                        |
|                      +-------------+  |    |           |                  |         |    |  +------------------+  |
+---------------------------------------+    |           |                  |         |    |  |  Firebase RTDB   |  |
                          ^                  |           |                  |         |    |  | (Real-time sync) |  |
                          |                  |           |                  |         |    |  +------------------+  |
                          +------------------+-----------+                  |         |    +------------------------+
                                             |                              |         |                 ^
                                             |                              |         |                 |
                                             |                              |         |                 |
                          +------------------v------------------------------v---------v-----------------+
                          |                             DATA SOURCES                                    |
                          |                                                                            |
                          |  +------------------+  +-------------------+  +----------------------+     |
                          |  |  WiFi counting   |  |  User Check-ins   |  | Historical Analytics |     |
                          |  |                  |  |                   |  |        Data          |     |
                          |  +------------------+  +-------------------+  +----------------------+     |
                          +----------------------------------------------------------------------------+


+-------------------------------------------------------------------------------------------------------------+
|                                          DEPLOYMENT INFRASTRUCTURE                                           |
|                                                                                                             |
|   +--------------+        +---------------+         +---------------+        +-------------------+          |
|   | CI/CD        |------->| App Stores    |         | Cloud Hosting |------->| Database Services |          |
|   | (GitHub      |        | (iOS/Android) |         | (AWS/GCP)     |        | (MongoDB Atlas,   |          |
|   |  Actions)    |        |               |         |               |        |  Redis Cloud)     |          |
|   +--------------+        +---------------+         +---------------+        +-------------------+          |
|                                                                                                             |
+-------------------------------------------------------------------------------------------------------------+
```

### Core Components

1. **Mobile Application (Frontend)**
   - **Framework**: Flutter for cross-platform development (iOS & Android)
   - **State Management**: Provider/Bloc pattern
   - **UI Components**: Material Design & Custom Widgets
   - **Local Storage**: Hive/SQLite for offline caching
   - **Maps Integration**: Google Maps API for location services
   - **Authentication**: Firebase Authentication with social login options

2. **Backend Services**
   - **API Layer**: REST API built with Node.js/Express
   - **Database**: 
     - MongoDB for user profiles, study spot metadata, and reviews
     - Redis for caching and real-time occupancy data
   - **Authentication**: JWT-based authentication with role-based access control
   - **Cloud Functions**: Firebase Cloud Functions for serverless operations

3. **Real-Time Occupancy System**
   - **Websockets**: Socket.io for real-time updates
   - **Data Collection**:
     - IoT sensors in participating locations (WiFi connection counting)
     - User check-ins and manual reporting
     - Predictive algorithms for estimating occupancy based on historical data

4. **External Integrations**
   - Google Maps Platform (Geolocation, Places API)
   - University SSO systems for academic verification
   - Push notification services (Firebase Cloud Messaging)
   - Payment processing for premium features (Stripe)

### Data Flow

1. User authentication and profile data flow through secure Firebase Authentication
2. Study spot queries are processed by the backend API and returned to the mobile app
3. Real-time occupancy updates are pushed via WebSockets to connected clients
4. User interactions (reviews, favorites) are stored in MongoDB with Redis caching
5. Analytics data is collected through Firebase Analytics for application improvement

### Security Measures

- End-to-end encryption for all data in transit
- Secure data storage with encryption at rest
- Rate limiting to prevent API abuse
- Input validation and sanitization to prevent injection attacks
- Regular security audits and penetration testing

### Deployment Strategy

- **Mobile App**: Continuous delivery through App Store and Google Play
- **Backend**: Containerized deployment with Docker on cloud platforms (AWS/GCP)
- **Database**: Managed database services with automated backups
- **CI/CD**: GitHub Actions for automated testing and deployment

This architecture ensures StudySphere can scale from a university-specific deployment to a multi-campus platform while maintaining performance and reliability.

---

## Data Collection & Insights

**StudySphere**'s development is driven by real user research. Key findings include:

- **Questionnaire Findings**  
  - Among 31 participants, over **77%** prefer on-campus libraries while **90%** rely on friend recommendations due to a lack of centralized information.  
  - Factors like seating capacity, lighting, and proximity to food/drinks were identified as essential.

- **Interview Insights**  
  - Students reported wasting 10–15 minutes during peak times searching for available seats.  
  - Library staff expressed interest in a digital solution to help manage and balance study space usage.

These insights informed the **five core design requirements** for the app:

1. **Match Users to Their Preferred Environment**  
   - Display study spots that align with individual needs (quiet areas, food proximity, large tables).

2. **Enable Peer Recommendations**  
   - Allow users to rate and review study spots.

3. **Highlight Proximity**  
   - Provide location-based search to find nearby study areas.

4. **Show Capacity & Busyness**  
   - Offer real-time occupancy data.

5. **List Opening & Closing Times**  
   - Display operational hours for each venue.

---

## Future Enhancements

1. **Reservation System Integration**  
   - Enable direct seat or group study room reservations within the app.  
   - Streamline the process of securing a spot during peak hours.

2. **Advanced Analytics**  
   - Utilize predictive modeling to forecast peak times and available seating.  
   - Offer insights to campus administrators on space utilization.

3. **Gamification**  
   - Reward active users with badges or points for posting reviews and sharing tips.  
   - Encourage community engagement through challenges and leaderboards.

4. **Campus Partnerships**  
   - Collaborate with local cafés and co-working spaces to provide student discounts.  
   - Integrate loyalty programs directly into the app.

---

## Contributing

We welcome contributions from students, educators, and developers. To contribute:

1. **Fork the Repository** on GitHub.  
2. **Create a Feature Branch** for your changes.  
3. **Submit a Pull Request** with a clear explanation of your proposed enhancements or bug fixes.  
4. Our team will review and integrate your changes if they align with the project goals.

---

## License

**StudySphere** is distributed under the [MIT License](https://opensource.org/licenses/MIT). You are free to use, modify, and distribute this software, provided that you retain the original license and copyright notices.

---
## Acknowledgments

Special thanks to the following people for their research and support:

- Jack Wiebe
- Jayden Chiola-Nakai
- Jaffar Keikei
- Klara Meng
- Luna Zayed
- Sophia de Uria
- Suhyeon Yoo (For feedback)
---
