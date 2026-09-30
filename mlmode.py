import pandas as pd
import mysql.connector
from sklearn.ensemble import RandomForestClassifier
from sklearn.preprocessing import OneHotEncoder
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Varun021",
    database="customer__360"
)

print("MySQL connected successfully!")
query = "SELECT * FROM customer_ml_dataset"

df_ml = pd.read_sql(query, conn)

print(df_ml.shape)
print(df_ml.head())
print(df_ml.isnull().sum())
print(df_ml.dtypes)
print(df_ml["Churn"].value_counts())
#model implementation
x=df_ml[['Recency','Frequency','Monetary','Country']]
y=df_ml["Churn"]
print("X.shape:",x.shape)
print("Y.shape:",y.shape)
from sklearn.preprocessing import OneHotEncoder
encode = OneHotEncoder(handle_unknown ='ignore',sparse_output=False)
Country_encoded = encode.fit_transform(x[['Country']])
print(Country_encoded.shape)
#combine features
import numpy as np
neumeric_features = x[['Recency','Frequency','Monetary']].values
x_final = np.hstack([neumeric_features,Country_encoded])
print("final X.shape:",x_final.shape)
# split data into train and test
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(x_final,y,test_size=0.2,random_state=42,stratify=y)
print("X_train.shape:",X_train.shape)
print("X_test.shape:",X_test.shape)
print("y_train.shape:",y_train.shape)
print("y_test.shape:",y_test.shape)
#Build the Random Forest Churn Model
from sklearn.ensemble import RandomForestClassifier
#create a model
model = RandomForestClassifier(
    n_estimators=200,
    random_state= 42,
    class_weight='balanced'
)
model.fit(X_train,y_train)
print("Random forest model trained successfully!")
#Generate Churn Predictions
y_pred = model.predict(X_test)
print("predictions genrated successfully!")
print(y_pred[:20])
#predictions of each class:
import numpy as np
print("predicted Active:",np.sum(y_pred==0))
print("predicted Churned:",np.sum(y_pred==1))
#Import evaluation metrics
from sklearn.metrics import accuracy_score,classification_report
#calcualte Accuracy
Accuracy = accuracy_score(y_test,y_pred)
print("model Accuracy:",Accuracy)
print("model Accuracy (%):",Accuracy*100)
print(classification_report(y_test, y_pred))
# improve Accuracy
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import GridSearchCV

param_grid = {
    'n_estimators': [100, 200],
    'max_depth': [5, 10, None],
    'class_weight': ['balanced']
}

grid = GridSearchCV(RandomForestClassifier(random_state=42),
                    param_grid, cv=3, scoring='accuracy')
grid.fit(X_train, y_train)

best_model = grid.best_estimator_
y_pred = best_model.predict(X_test)
print("Improved Accuracy:", accuracy_score(y_test, y_pred))
scoring='f1'
y_pred = best_model.predict(X_test)
from sklearn.metrics import accuracy_score, classification_report

print("Best Parameters:", grid.best_params_)
print("Accuracy:", accuracy_score(y_test, y_pred))
print(classification_report(y_test, y_pred))

