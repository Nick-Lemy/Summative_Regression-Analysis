# EduCareer AI - Unemployment Rate Predictor

A modern Flutter application for predicting unemployment rates in African countries based on education indicators using machine learning.

## Features

- 🎓 Education-focused modern UI design
- 📊 Real-time prediction of unemployment rates
- 🎯 Form validation with range checking
- 💫 Smooth animations and transitions
- 📱 Responsive design
- 🌍 Africa-focused education data analysis

## Project Structure

```
lib/
├── main.dart                          # App entry point
├── constants/
│   ├── app_colors.dart               # Color palette (blue/green education theme)
│   └── app_theme.dart                # Theme configuration
├── screens/
│   └── prediction_page.dart          # Main prediction interface
└── widgets/
    ├── app_logo.dart                 # Custom education-themed logo
    ├── custom_text_field.dart        # Styled input fields
    ├── gradient_button.dart          # Gradient action button
    └── result_card.dart              # Prediction result display
```

## Design Features

### Color Scheme
- Primary: Deep blue (#1E3A8A) - Trust and education
- Secondary: Green (#10B981) - Growth and opportunity
- Accent: Amber (#F59E0B) - Achievement
- Gradient: Blue gradient for academic feel

### Custom Components

1. **AppLogo** - Graduation cap icon with education branding
2. **CustomTextField** - Enhanced input fields with validation
3. **GradientButton** - Call-to-action button
4. **ResultCard** - Green gradient card for predictions

## Input Parameters

The app accepts six education and demographic indicators:

1. **Male Upper Secondary Completion Rate** (0-100%)
2. **Female Upper Secondary Completion Rate** (0-100%)
3. **Male Youth Literacy Rate** (0-100%)
4. **Female Youth Literacy Rate** (0-100%)
5. **Tertiary Education Enrollment** (0-100%)
6. **Birth Rate** (0-60 per 1000)

## API Integration

Connects to FastAPI backend at `http://127.0.0.1:8000/predict`

### Request Format
```json
{
  "completion_rate_upper_secondary_male": 85.5,
  "completion_rate_upper_secondary_female": 82.3,
  "gross_tertiary_education_enrollment": 45.2,
  "youth_literacy_rate_male": 92.1,
  "youth_literacy_rate_female": 88.7,
  "birth_rate": 28.5
}
```

### Response Format
```json
{
  "predicted_unemployment_rate": 12.34
}
```

## Running the App

### Development
```bash
flutter pub get
flutter run -d chrome  # For web
flutter run -d linux   # For Linux desktop
```

### Build for Web
```bash
flutter build web
cd build/web
python3 -m http.server 8080
```

## About the Data

This predictor uses regression analysis on the **Global Education Dataset** to predict unemployment rates based on education indicators across African countries. The model helps understand the relationship between education metrics and employment outcomes.

