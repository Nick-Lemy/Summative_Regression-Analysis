# Unemployment Rate Prediction in Africa

## Mission
Providing cybersecurity education in Africa, especially in Congo-Brazzaville. This model predicts unemployment rates based on education indicators to identify regions where training programs, including cybersecurity education, can improve job outcomes and reduce unemployment.

## Dataset
**Source:** World Educational Data from [Kaggle](https://www.kaggle.com/datasets/nelgiriyewithana/world-educational-data)

**Description:** Dataset contains education indicators for 202 countries worldwide. Filtered to 51 African countries with features including completion rates, literacy rates, tertiary enrollment, and birth rates. Target variable is unemployment rate.

## API Endpoint
**Public URL:** `https://summative-regression-analysis.onrender.com/predict`

**Swagger UI Documentation:** `https://summative-regression-analysis.onrender.com/docs`

### Input Parameters
- `completion_rate_upper_secondary_male` (float, 0-100)
- `completion_rate_upper_secondary_female` (float, 0-100)
- `gross_tertiary_education_enrollment` (float, 0-100)
- `youth_literacy_rate_male` (float, 0-100)
- `youth_literacy_rate_female` (float, 0-100)
- `birth_rate` (float, 0-60)

### Example Request
```json
{
  "completion_rate_upper_secondary_male": 25,
  "completion_rate_upper_secondary_female": 20,
  "gross_tertiary_education_enrollment": 15,
  "youth_literacy_rate_male": 70,
  "youth_literacy_rate_female": 65,
  "birth_rate": 30
}
```

### Example Response
```json
{
  "predicted_unemployment_rate": 8.45
}
```

## Live Demo
**Web App:** http://3.95.222.45:3010

**API:** https://summative-regression-analysis.onrender.com/docs

## Video Demo
[YouTube Video Link](https://youtube.com/your-video-link)

## Project Structure
```
summative/
├── linear_regression/
│   └── multivariate.ipynb       # Model training notebook
├── API/
│   ├── prediction.py            # FastAPI application
│   ├── requirements.txt         # Python dependencies
│   ├── best_model.pkl          # Trained model
│   └── scaler.pkl              # Feature scaler
└── FlutterApp/
    └── lib/
        └── main.dart           # Flutter mobile app
```

## Running the FastAPI Server Locally

### Prerequisites
- Python 3.8 or higher
- pip package manager

### Steps
1. Clone the repository:
```bash
git clone https://github.com/Nick-Lemy/Summative_Regression-Analysis
cd ./Summative_Regression-Analysis/API
```

2. Install dependencies:
```bash
pip install -r requirements.txt
```

3. Make sure `best_model.pkl` and `scaler.pkl` are in the API folder

4. Run the server:
```bash
uvicorn prediction:app --reload
```

5. Access the API:
   - **Base URL:** http://127.0.0.1:8000
   - **Swagger UI:** http://127.0.0.1:8000/docs
   - **Prediction endpoint:** http://127.0.0.1:8000/predict

6. Test in Swagger UI or use curl:
```bash
curl -X POST "http://127.0.0.1:8000/predict" \
     -H "Content-Type: application/json" \
     -d '{
       "completion_rate_upper_secondary_male": 25,
       "completion_rate_upper_secondary_female": 20,
       "gross_tertiary_education_enrollment": 15,
       "youth_literacy_rate_male": 70,
       "youth_literacy_rate_female": 65,
       "birth_rate": 30
     }'
```

## Running the Mobile App

### Prerequisites
- Flutter SDK installed ([Install Flutter](https://flutter.dev/docs/get-started/install))
- Android Studio / Xcode (for emulator)
- Device or emulator running

### Steps
1. Navigate to Flutter app directory:
```bash
cd summative/FlutterApp
```

2. Install dependencies:
```bash
flutter pub get
```

3. Update API URL in `lib/main.dart` (line 36):
   - For deployed API: `https://summative-regression-analysis.onrender.com/predict`
   - For local testing: `http://10.0.2.2:8000/predict` (Android emulator)
   - For local testing: `http://localhost:8000/predict` (iOS simulator)

4. Run the app:
```bash
flutter run
```

5. Select your target device when prompted

6. Enter education indicator values and click "Predict" to get unemployment rate prediction

### Running on Physical Device
If running on a physical Android device and testing with local API:
- Find your computer's local IP address
- Use `http://YOUR_LOCAL_IP:8000/predict` in the app

## Model Performance
- **Linear Regression (SGD):** MSE = 26.84 ✓ (Best Model)
- **Decision Tree:** MSE = [value]
- **Random Forest:** MSE = [value]

The Linear Regression model trained with Stochastic Gradient Descent achieved the lowest MSE and was selected for deployment.

## Technologies Used
- **Machine Learning:** Python, scikit-learn, pandas, numpy
- **API:** FastAPI, Pydantic, uvicorn
- **Mobile App:** Flutter, Dart
- **Deployment:** Render (API), Custom Server (Web App)
- **Visualization:** matplotlib, seaborn