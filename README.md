SipSmarter is a data-driven application that:
* Tracks alcohol consumption
* Aggregates user behavior
* Uses AI and RAG to generate personalized insights

Getting Started

These instructions explain how to run the SipSmarter Flutter app locally.
The app is already configured to use an existing Firebase backend, so no additional Firebase setup is required.
You can also try this link to test the app, rather than going through the process of setting it up for local run: https://app.flutterflow.io/run/yzQF4K9cONclFe0fxhaZ
Prerequisites

Make sure you have the following installed:

* Flutter SDK (latest stable): https://docs.flutter.dev/get-started/install
* Dart (included with Flutter)
* Android Studio or VS Code (with Flutter plugin)

Clone the Repository
git clone https://github.com/KyleJMard/EGR404-Project-AI-Sponsor-
cd sipsmarter

Install Dependencies: 
* flutter pub get

Firebase Configuration:
* No setup is required.

This project already includes Firebase configuration files (firebase_options.dart), and connects to a preconfigured backend. The app will automatically use the existing Firestore database and authentication system.

API Configuration

The app is preconfigured to call a deployed backend function.

If needed, verify the API endpoint in the exported code (typically in api_calls.dart or similar):

const String baseUrl = "https://your-cloud-function-url";
Run the App
Run on emulator or physical device:
flutter run
Run on web:
flutter run -d chrome

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# SipSmarter AI — Python Cloud Function (RAG-Based Insight Engine)

## Overview

This project implements a cloud-based AI pipeline that analyzes user drinking behavior and generates personalized insights. The system is built using a Python HTTP-triggered Cloud Function that integrates Firestore data, a Retrieval-Augmented Generation (RAG) layer, and the OpenAI API to produce meaningful, context-aware recommendations.

The goal of this system is to transform raw behavioral data into actionable feedback that helps users better understand and manage their alcohol consumption.

---

## System Architecture

The pipeline follows a structured flow:

```
Client (FlutterFlow)
        ↓
HTTP Request (user_id)
        ↓
Python Cloud Function
        ├── Firestore Query (drinkTotals)
        ├── Data Aggregation
        ├── RAG Context Retrieval
        ├── OpenAI API Call
        └── JSON Response (AI Insight + Metrics)
```

---

## Key Features

* **Cloud-based processing** using Python HTTP functions
* **Firestore integration** for real-time user data retrieval
* **RAG (Retrieval-Augmented Generation)** to ground AI responses in domain knowledge
* **OpenAI integration** for natural language insight generation
* **Data aggregation** for summarizing user behavior (drinks, calories, cost)
* **Structured API response** for seamless frontend integration

---

## Data Flow

1. The client sends a POST request containing a `user_id`
2. The function queries the `drinkTotals` collection in Firestore
3. Relevant fields are extracted:

   * `count`
   * `calories`
   * `cost`
4. Data is aggregated into summary metrics
5. A RAG layer retrieves relevant health guidance from a knowledge base
6. The OpenAI model generates a concise insight and recommendation
7. The function returns a structured JSON response

---

## RAG Implementation

The system incorporates a lightweight Retrieval-Augmented Generation approach:

* A predefined knowledge base contains domain-specific guidance
* Each entry is converted into vector embeddings
* The user summary is embedded at runtime
* Cosine similarity is used to retrieve the most relevant context
* Retrieved context is injected into the LLM prompt

This ensures that generated responses are:

* Grounded in factual guidance
* Contextually relevant
* Less generic than standard AI outputs

---

## API Specification

### Endpoint

```
POST /get_user_drink_totals
```

### Request Body

```json
{
  "uid": "USER_FIREBASE_UID"
}
```

### Response

```json
{
  "ai_summary": "Your alcohol intake is relatively low, but even small amounts add calories quickly. Consider spacing drinks to manage long-term impact.",
  "totals": {
    "drinks": 3,
    "calories": 450,
    "cost": 12.5
  }
}
```

---

## Core Components

### 1. Firestore Query

Filters user-specific data:

```python
db.collection("drinkTotals") \
  .where("ownerUid", "==", uid) \
  .where("removed", "==", False)
```

---

### 2. Data Aggregation

Calculates:

* Total drinks
* Total calories
* Total cost

---

### 3. RAG Layer

* Embeds knowledge base entries
* Computes similarity against user summary
* Selects top relevant context

---

### 4. OpenAI Integration

* Uses `gpt-4o-mini` model
* Generates:

  * Behavioral insight
  * Actionable recommendation
* Prompt constrained for:

  * Plain text output
  * Concise responses
  * No formatting artifacts

---

## Security Considerations

* API keys are managed via environment variables / secret management
* No credentials are hardcoded
* Input validation ensures required fields are present
* Backend logic avoids trusting malformed client input

---

## Error Handling

The system includes safeguards for:

* Missing request data
* Empty user datasets
* OpenAI API failures
* Embedding or retrieval issues

Fallback responses ensure the API always returns a valid result.

---

## Technologies Used

* Python (Cloud Function runtime)
* Google Firestore
* OpenAI API
* Vector similarity (cosine similarity)
* Flask (HTTP handling)

---

## Future Improvements

* Trend analysis (week-over-week comparisons)
* Personalized RAG using user history
* Behavioral pattern detection
* Secure authentication via Firebase ID token verification
* Scalable vector database (e.g., Pinecone or Chroma)

---

## Conclusion

This project demonstrates how structured data and AI can be combined to create meaningful, real-time insights. By integrating Firestore, a RAG pipeline, and a language model, the system moves beyond simple data reporting to deliver intelligent, context-aware feedback that can support behavioral change.

---
