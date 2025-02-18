# StudySphere: Empowering Students to Discover the Perfect Study Spot

Welcome to **StudySphere**—an innovative application designed to help university students easily discover, evaluate, and select their ideal study spaces. By consolidating location details (e.g., capacity, availability, hours of operation, and more) into a single interactive platform, **StudySphere** addresses a critical student need: reducing time spent searching for study spots and maximizing time spent actually studying.

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
   - **Map View** pinpoints each study spot’s location, aiding quick navigation.  
   - **List View** offers a sortable directory of spaces by distance, rating, or capacity.

6. **Reservation System (Proposed)**  
   - Potential in future iterations: reserve individual seats or group study rooms in-app.  
   - Minimizes time spent wandering through halls to find a suitable table or group-friendly area.

---

## Installation and Setup

> **Note**: StudySphere’s prototype can be tailored as a **mobile application**.

1. **Clone the Repository & Install Dependencies**

    git clone https://github.com/jaffarkeikei/StudySphere.git  
    cd StudySphere  

    flutter pub get

2. **Configure Environment Variables**  
   - Create a `.env` file (or the relevant configuration file) to store any API keys or server URLs.  

3. **Run the Application**  
   - For a mobile app (Flutter):

        flutter run

   - The application should now be accessible locally or on a connected device/emulator.

---

## Usage

1. **Create an Account / Log In**  
   - Users can create accounts using their university email or social logins.

2. **Set Your Preferences**  
   - Choose how far you’re willing to walk or commute, your noise-level tolerance, preference for group vs. individual seating, etc.  
   - The app saves these preferences for future recommendations.

3. **Browse Study Spots**  
   - View suggested or popular spots based on your settings.  
   - Sort results by rating, distance, or capacity.

4. **Filter & Refine**  
   - Apply dynamic filters (e.g., *“Must have power outlets,”* *“Open 24 hours,”* *“Has a café nearby”*).

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

> *This section provides a high-level overview; actual architecture may vary based on your tech stack.*

1. **Front-End**  
   - Built using modern frameworks like React for web or Flutter for mobile.  
   - Communicates with the back-end via RESTful or GraphQL APIs.

2. **Back-End**  
   - Developed using Node.js/Express or Django to manage user accounts, study spot data, and real-time seat availability.  
   - Uses databases (e.g., PostgreSQL) to store user preferences, location information, and reviews.

3. **Real-Time Occupancy Tracking**  
   - Could incorporate IoT sensors in physical locations or rely on crowd-sourced check-ins.  
   - A dedicated microservice aggregates and estimates current occupancy levels.

4. **Third-Party Integrations**  
   - Mapping APIs (e.g., Google Maps, Mapbox) for location services.  
   - Social login integrations for simplified user authentication.  
   - Notification services (e.g., Firebase Cloud Messaging) for real-time alerts on seat availability.

---

## Data Collection & Insights

**StudySphere**’s development is driven by real user research. Key findings include:

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
