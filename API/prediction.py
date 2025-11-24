from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field
import joblib
import numpy as np

# Load model and scaler
model = joblib.load('../linear_regreation/best_model.pkl')
scaler = joblib.load('../linear_regreation/scaler.pkl')

# Create FastAPI app
app = FastAPI(
    title="Unemployment Rate Prediction API",
    description="Predicts unemployment rates in African countries based on education indicators"
)

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Input schema with data types and range constraints
class PredictionInput(BaseModel):
    completion_rate_upper_secondary_male: float = Field(..., ge=0, le=100, description="Male upper secondary completion rate (%)")
    completion_rate_upper_secondary_female: float = Field(..., ge=0, le=100, description="Female upper secondary completion rate (%)")
    gross_tertiary_education_enrollment: float = Field(..., ge=0, le=100, description="Tertiary education enrollment (%)")
    youth_literacy_rate_male: float = Field(..., ge=0, le=100, description="Male youth literacy rate (%)")
    youth_literacy_rate_female: float = Field(..., ge=0, le=100, description="Female youth literacy rate (%)")
    birth_rate: float = Field(..., ge=0, le=60, description="Birth rate per 1000 people")

# Output schema
class PredictionOutput(BaseModel):
    predicted_unemployment_rate: float


# Prediction endpoint
@app.post("/predict", response_model=PredictionOutput)
def predict(data: PredictionInput):
    input_data = np.array([[
        data.completion_rate_upper_secondary_male,
        data.completion_rate_upper_secondary_female,
        data.gross_tertiary_education_enrollment,
        data.youth_literacy_rate_male,
        data.youth_literacy_rate_female,
        data.birth_rate
    ]])
    
    input_scaled = scaler.transform(input_data)
    prediction = model.predict(input_scaled)[0]
    
    return PredictionOutput(predicted_unemployment_rate=round(prediction, 2))
