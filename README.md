# Cybersecurity Threats Financial Impact - Regression Analysis

## Project Overview
This project analyzes global cybersecurity threats from 2015-2024 and predicts the financial impact of cyber attacks using regression models. The analysis addresses the critical need to understand and predict financial losses from various types of cyber attacks across different industries.

## Dataset
- **Source**: Kaggle - Global Cybersecurity Threats 2015-2024
- **Records**: 3,000 cybersecurity incidents
- **Time Period**: 2015 - 2024
- **Target Variable**: Financial Loss (in Million $)

### Features
- Country
- Year
- Attack Type (DDoS, Malware, Man-in-the-Middle, Phishing, Ransomware, SQL Injection)
- Target Industry (Education, Finance, Government, Healthcare, IT, Retail, Telecommunications)
- Number of Affected Users
- Attack Source (Hacker Group, Insider, Nation-state, Script Kiddie)
- Security Vulnerability Type
- Defense Mechanism Used
- Incident Resolution Time (Hours)

## Requirements

### Python Libraries
```bash
pip install pandas numpy matplotlib seaborn scikit-learn joblib
```

## Project Structure

```
Summative_Regression-Analysis/
│
├── summative.ipynb              # Main analysis notebook
├── predict.py                   # Prediction script for Task 2
├── Global_Cybersecurity_Threats_2015-2024.csv
├── best_model.pkl              # Saved best performing model
├── scaler.pkl                  # Saved feature scaler
├── label_encoders.pkl          # Saved label encoders
└── README.md                   # This file
```

## Analysis Components

### 1. Data Visualization and Interpretation
- Correlation heatmap showing feature relationships
- Financial impact analysis by attack type
- Scatter plots showing user impact vs financial loss
- Distribution and box plots of financial losses

### 2. Feature Engineering
- **Categorical Encoding**: Label encoding for 6 categorical variables
- **Standardization**: StandardScaler for feature normalization (mean=0, std=1)
- **Train-Test Split**: 80% training (2,400 samples), 20% testing (600 samples)

### 3. Models Implemented
All models use scikit-learn library:

1. **Linear Regression**
   - Classical linear regression with gradient descent optimization
   - Best performing model for this dataset

2. **Random Forest Regressor**
   - Ensemble method with 100 trees
   - Max depth: 10
   - Provides feature importance analysis

3. **Decision Tree Regressor**
   - Single decision tree
   - Max depth: 10
   - Interpretable model structure

### 4. Model Evaluation

**Metrics Used:**
- R² Score (Coefficient of Determination)
- RMSE (Root Mean Squared Error)
- MAE (Mean Absolute Error)

**Visualizations:**
- Loss curves (Train vs Test)
- Before/After scatter plots showing prediction lines
- Actual vs Predicted comparison plots
- Feature importance charts

### 5. Model Performance

| Model | Test R² | Test RMSE | Test MAE |
|-------|---------|-----------|----------|
| Linear Regression | -0.0045 | $28.50M | $24.66M |
| Random Forest | -0.0185 | $28.70M | $24.72M |
| Decision Tree | -0.1180 | $30.07M | $25.46M |

**Best Model**: Linear Regression (saved as `best_model.pkl`)

## Key Findings

1. **Feature Importance**: Number of Affected Users is the most important predictor (28.6% importance)
2. **Prediction Challenge**: Low R² scores indicate financial loss is difficult to predict with current features alone
3. **Model Stability**: All models show consistent performance between training and testing sets
4. **Industry Patterns**: Attack types show relatively uniform average financial impact ($49-52M range)

## Usage

### Running the Analysis
1. Open `summative.ipynb` in Jupyter Notebook or VS Code
2. Run all cells sequentially
3. Models will be trained and saved automatically

### Making Predictions
Use the `predict.py` script:

```python
from predict import predict_financial_loss

prediction = predict_financial_loss(
    country='USA',
    year=2024,
    attack_type='Ransomware',
    target_industry='Healthcare',
    num_affected_users=500000,
    attack_source='Hacker Group',
    vulnerability_type='Unpatched Software',
    defense_mechanism='Firewall',
    resolution_time=48
)

print(f"Predicted Financial Loss: ${prediction:.2f} Million")
```

Or run the script directly:
```bash
python predict.py
```

## Task 1 Completion Checklist

✅ Non-generic use case (Cybersecurity financial impact prediction)  
✅ Dataset from Kaggle (not house price prediction)  
✅ Regression-specific data analysis  
✅ Multiple data visualizations with interpretations  
✅ Feature engineering (encoding, standardization)  
✅ Data conversion to numeric format  
✅ Linear Regression model using scikit-learn  
✅ Decision Tree model implementation  
✅ Random Forest model implementation  
✅ Loss curves plotted (train vs test)  
✅ Scatter plots before/after showing regression lines  
✅ Best performing model saved  
✅ Prediction script created for Task 2  

## Future Improvements

1. Collect additional features (attack sophistication, prior incidents, security budget)
2. Engineer new features (attack frequency, seasonal patterns)
3. Experiment with polynomial features
4. Try ensemble methods with feature selection
5. Implement cross-validation for more robust evaluation

## Author
ALU Data Science Student - Summative Regression Analysis Assignment

## Date
November 20, 2025
