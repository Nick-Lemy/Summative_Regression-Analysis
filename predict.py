"""
Cybersecurity Financial Loss Prediction Script
Uses the trained model to predict financial impact of cyber attacks
"""

import pandas as pd
import joblib
import sys


def predict_financial_loss(country, year, attack_type, target_industry, 
                          num_affected_users, attack_source, vulnerability_type, 
                          defense_mechanism, resolution_time):
    """
    Predict financial loss for a cybersecurity incident
    
    Parameters:
    -----------
    country : str - Country where attack occurred
    year : int - Year of attack
    attack_type : str - Type of cyber attack (DDoS, Malware, Man-in-the-Middle, Phishing, Ransomware, SQL Injection)
    target_industry : str - Industry targeted (Banking, Education, Government, Healthcare, IT, Retail, Telecommunications)
    num_affected_users : int - Number of users affected
    attack_source : str - Source of attack (Hacker Group, Insider, Nation-state, Unknown)
    vulnerability_type : str - Type of security vulnerability (Social Engineering, Unpatched Software, Weak Passwords, Zero-day)
    defense_mechanism : str - Defense mechanism used (AI-based Detection, Antivirus, Encryption, Firewall, VPN)
    resolution_time : int - Time to resolve incident (hours)
    
    Returns:
    --------
    float - Predicted financial loss in million dollars
    """
    
    try:
        # Load saved model and preprocessing objects
        model = joblib.load('best_model.pkl')
        scaler = joblib.load('scaler.pkl')
        encoders = joblib.load('label_encoders.pkl')
        
        # Create input dataframe
        input_data = pd.DataFrame({
            'Country': [country],
            'Year': [year],
            'Attack Type': [attack_type],
            'Target Industry': [target_industry],
            'Number of Affected Users': [num_affected_users],
            'Attack Source': [attack_source],
            'Security Vulnerability Type': [vulnerability_type],
            'Defense Mechanism Used': [defense_mechanism],
            'Incident Resolution Time (in Hours)': [resolution_time]
        })
        
        # Encode categorical variables
        for col in encoders.keys():
            if col in input_data.columns:
                input_data[col] = encoders[col].transform(input_data[col])
        
        # Standardize features
        input_scaled = scaler.transform(input_data)
        
        # Make prediction
        prediction = model.predict(input_scaled)[0]
        
        return prediction
        
    except FileNotFoundError:
        print("Error: Model files not found. Please run the training notebook first.")
        sys.exit(1)
    except Exception as e:
        print(f"Error during prediction: {str(e)}")
        sys.exit(1)


if __name__ == "__main__":
    # Example predictions
    print("=" * 70)
    print("CYBERSECURITY FINANCIAL LOSS PREDICTION SYSTEM")
    print("=" * 70)
    
    # Example 1: Ransomware attack on Healthcare
    print("\nExample 1: Ransomware Attack on Healthcare")
    prediction1 = predict_financial_loss(
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
    print(f"Predicted Financial Loss: ${prediction1:.2f} Million")
    
    # Example 2: Phishing attack on Banking
    print("\nExample 2: Phishing Attack on Banking Sector")
    prediction2 = predict_financial_loss(
        country='UK',
        year=2024,
        attack_type='Phishing',
        target_industry='Banking',
        num_affected_users=750000,
        attack_source='Nation-state',
        vulnerability_type='Social Engineering',
        defense_mechanism='AI-based Detection',
        resolution_time=24
    )
    print(f"Predicted Financial Loss: ${prediction2:.2f} Million")
    
    # Example 3: DDoS attack on IT
    print("\nExample 3: DDoS Attack on IT Infrastructure")
    prediction3 = predict_financial_loss(
        country='China',
        year=2024,
        attack_type='DDoS',
        target_industry='IT',
        num_affected_users=300000,
        attack_source='Unknown',
        vulnerability_type='Weak Passwords',
        defense_mechanism='Encryption',
        resolution_time=12
    )
    print(f"Predicted Financial Loss: ${prediction3:.2f} Million")
    
    print("\n" + "=" * 70)
    print("Note: Predictions are based on the trained regression model")
    print("=" * 70)
