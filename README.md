# AgingInPlace - MVP

A comprehensive mobile application designed to help families track their aging parents' ability to live independently at home. The app calculates an "AIP Score" (Aging In Place Score) based on Health, Care Team, and Home Safety factors, utilizing AI for natural language assessment.

## 🌟 Key Features

*   **AIP Score Calculation:** A proprietary algorithm that balances Functional Well-Being (Health), Care Team Support, and Environmental Safety.
*   **AI-Powered Assessment Chat:** An intuitive chat interface where users describe observations (e.g., "Mom fell in the kitchen"), and the AI (Gemini) automatically updates the relevant scoring metrics.
*   **Exception-Based Reporting:** Assessments start at a "Perfect Health" baseline (100) and adjust downwards based on reported issues, minimizing data entry fatigue.
*   **Dynamic Dashboard:**
    *   **Real-time Visualization:** Circular progress for AIP Score, Bar Charts for sub-scores.
    *   **Trend Analysis:** Gradient area chart showing score history over time.
    *   **Smart Recommendations:** Actionable cards (e.g., "Fall Risk", "Care Gap") triggered by specific score drops or improvements.
*   **Humanized Onboarding:** The AI interviews the user to establish context (Name, Age, Gender, Living Situation) before starting the assessment.
*   **Multi-User Support:** Secure Firebase Authentication and Firestore backend for storing assessments per user.

## 🛠 Tech Stack

*   **Framework:** Flutter (iOS, Android, Web)
*   **State Management:** Riverpod (2.0+)
*   **Navigation:** GoRouter
*   **Backend:** Firebase (Auth, Firestore)
*   **AI Integration:** Firebase Vertex AI (Gemini 2.0 Flash)
*   **Data Models:** Freezed & JSON Serializable
*   **Charts:** fl_chart

## 📂 Project Structure

```
lib/
├── core/               # App-wide constants, theme, utils
├── features/           # Feature-based modular architecture
│   ├── assessment/     # Chat UI & Logic (AssessmentController)
│   ├── auth/           # Login & Onboarding (ScoreExplainerSheet)
│   └── dashboard/      # Main Dashboard & Visualization
├── models/             # Immutable Data Models (Assessment, Recommendation)
├── services/           # Backend Integrations (Firestore, AI, Auth, Scoring)
└── main.dart           # App Entry Point & ProviderScope
```

## 🚀 Getting Started

### Prerequisites
*   Flutter SDK (3.x+)
*   Firebase CLI
*   Dart 3.x+

### Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/aging-in-place.git
    cd aging-in-place
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Code Generation (Required for Models):**
    This project uses `freezed` and `riverpod`. You must run the build runner:
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```

4.  **Firebase Setup:**
    *   Ensure `firebase_options.dart` is configured for your project.
    *   Enable **Authentication** (Email/Password).
    *   Enable **Firestore Database**.
    *   Enable **Vertex AI** in the Firebase Console.

5.  **Run the App:**
    ```bash
    flutter run
    ```

## 🧠 Core Logic

### The AIP Formula
The score is calculated in `ScoringService` roughly as:
> `Score = (Health_Metrics * Care_Team_Multiplier) - Environmental_Hazards`

*   **Health (FWB):** ADLs (Bathing, Dressing), Gait Speed, Grip Strength.
*   **Care (CT):** Coverage Frequency, Reliability.
*   **Environment (ES):** Fall Hazards, Bathroom Safety.

### AI Processing
1.  **Input:** User types "Dad is forgetting to eat."
2.  **Process:** `AIService` sends current JSON state + Observation to Gemini.
3.  **Logic:** Gemini acts as a Geriatric Care Manager, updating specific fields (e.g., `preparing_meals: 1`).
4.  **Output:** App recalculates score and updates Dashboard.

## 📸 Screenshots

*(Add screenshots of Dashboard, Chat, and Login here)*

## 📄 License

Proprietary - Do not distribute without permission.
