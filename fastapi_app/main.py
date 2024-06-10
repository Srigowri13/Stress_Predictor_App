from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import numpy as np
import pandas as pd
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import train_test_split
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

# Enable CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Load and preprocess the data
df = pd.read_csv("C:/Users/sgowr/stress_predictor_project/fastapi_app/Student Stress Factors (2) (3).csv")
desired_rows = 30000
repeated_data = pd.concat([df] * (desired_rows // len(df)), ignore_index=True)
remaining_rows = desired_rows % len(df)
if (remaining_rows > 0):
    data = pd.concat([repeated_data, df[:remaining_rows]], ignore_index=True)

X = data.drop('How would you rate your stress levels?', axis=1)
Y = data['How would you rate your stress levels?']
X_train, X_test, Y_train, Y_test = train_test_split(X, Y, train_size=0.7)
model = KNeighborsClassifier(n_neighbors=3)
model.fit(X_train, Y_train)

class StressInput(BaseModel):
    q1: int
    q2: int
    q3: int
    q4: int
    q5: int

@app.post("/predict")
async def predict(stress_input: StressInput):
    print(stress_input)
    input_data = np.array([[stress_input.q1, stress_input.q2, stress_input.q3, stress_input.q4, stress_input.q5]])
    stress_level = model.predict(input_data)[0]
    if stress_level <= 2:
        stress_category = "Low Stress"
    elif stress_level <= 4:
        stress_category = "Moderate Stress"
    else:
        stress_category = "High Stress"
    print(stress_level)
    print(stress_category)
    return {"stress_level": stress_level, "stress_category": stress_category}
