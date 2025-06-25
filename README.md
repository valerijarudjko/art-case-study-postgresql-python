# Data Case Study with Pandas - Famous Paintings
 
 ## Create your environment
```bash
python3.11.1 -m venv my_env1    # <-- choose yoor python version and name of your environment
```
1. Open your VS Code integrated terminal and run:
```bash
pip install pandas
pip install sqlalchemy          # <-toolkit that simplifies the connection between Python and SQL databases
pip install psycopg2-binary     # <-database adapter for the Python
```

2. Download & unzip the dataset
- In VS Code terminal run:
```bash
kaggle datasets download \
  -d mexwell/famous-paintings\
  -p data/amous-paintings \
  --unzip
```

-d specifies the dataset slug; -p sets the target directory; --unzip extracts the files in place

- Load the data in Python:
In your .py or Jupyter file, use pandas to read whichever CSV(s) you need.

- For example (adjust the filename to match what was unzipped):
```bash
df = pd.read_csv('data/famous-paintings.csv')
print(df.head())
```
## Conecting python to Postgresql database
```python
conn_string = 'postgresql://user:password@localhost:0000/database'
engine = create_engine(conn_string)

db = create_engine(conn_string)
conn = db.connect()

try:
    conn = engine.connect()
    print(" Connection successful!")
except Exception as e:
    print(" Connection failed:", e)

from sqlalchemy import text

result = conn.execute(text("SELECT version();"))

for row in result:
    print(row)
```
----
## Optional: Using .env for Security (Recommended):


```python
pip install python-dotenv
```


- Create a .env file:
```python
DB_USER=
DB_PASS=
DB_NAME=
DB_HOST=
DB_PORT=
```
- Update Python code:
```python
import os
from dotenv import load_dotenv
from sqlalchemy import create_engine

load_dotenv()

conn_string = f"postgresql://{os.getenv('DB_USER')}:{os.getenv('DB_PASS')}@{os.getenv('DB_HOST')}:{os.getenv('DB_PORT')}/{os.getenv('DB_NAME')}"
engine = create_engine(conn_string)
conn = engine.connect()
```
____


## Creating a loop
```python
files = ['artist', 'canvas_size', 'image_link', 'museum_hours', 'museum', 'product_size', 'subject', 'work']

for file in files:
    df = pd.read_csv(f'/Users/user/Desktop/art/{file}.csv')
    df.to_sql(file, con=engine, schema='public', if_exists='replace', index=False)
    print(f" Uploaded: {file}")
```

_____

## Case Study in the 'art' Database PostgreSQL

### Problem Statements:

1) List all the paintings which are not displayed on any museums?
2) Are there museums without any paintings?

---

#### Acknowledgments
- Data Source: Kaggle’s Famous Art
- Inspiration: @techtfq
