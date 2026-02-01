# SQL, ORM, and No SQL Comparison

**Student Name:** [Lloyd]
**Date:**[31/01/2026]

---

## 1. SQL (Structured Query Languege)

### What is it?

[A type of language like python.]

### Advantages
- [Simple, Powerful]

### Disadvantages
- [More code, Manual world]

### When to use
- [Structred data, Require ACID transcations]
### Example Query
```sql
[CREATE TABLE IF NOT EXISTS table 1 (
id INTEGER PRIMARY KEY AUTOINCREMENT,
a TEXT,
b TEXT,
c TEXT
);]
```
---


## 2. ORM (Object-Relational Mapping)
### What is it?
[database operation in programming language]

### Advantages
- [Less code, Relationships]

### Disadvantages
- [Less control, Learning curve(understand both ORM syntax and underlying SQL concepts)]

### When to use
- [Apps needing rapid development, prefer object-oriented code]

### Example Code (SQLAlchemy)
```python
[# lesson10_orm_demo.py
from sqlalchemy import create_engine, Column, Integer, String, ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, relationship

# Create base class for models
Base = declarative_base()

# Define Character model (like a table)
class Character(Base):
    __tablename__ = 'characters'

    id = Column(Integer, primary_key=True)
    name = Column(String, nullable=False)
    species = Column(String)
    height = Column(Integer)
    homeworld_id = Column(Integer, ForeignKey('planets.id'))

    # Relationship to Planet
    homeworld = relationship("Planet", back_populates="characters")

    def __repr__(self):
        return f"<Character(name='{self.name}', species='{self.species}')>"]
```


---
## 3. NoSQL (Document Database)
### What is it?
[databases store data in formats other than tables]
### Example Document Structure
```json
{
"_id": "507f1f77bcf86cd799439011",
"name": "Luke Skywalker",
"species": "Human",
"height": 172,
"homeworld": {
"name": "Tatooine",
"climate": "arid",
"population": 200000
},
"vehicles": [
{
"name": "X-wing",
"class": "Starfighter"
},
{
"name": "Snowspeeder",
"class": "Airspeeder"
}
]
}
}
```
### Advantages
- [Flexible schema, Horizontal scalability]
### Disadvantages
- [Data duplication, complex queries less efficient]
### When to use
- [Schema changes frequently, Need horizontal scaling]
---


## 4. My Recommendation
For the Star Wars database project, I would choose:
**[SQL]** because:
[When I'm doing this project I noticed that the data need to be structured and stored into table (because there are a lot and need to be in specific categories). It's greate to also include ORM, however, it's not suitable for me because there are too much complex things going on that need to be compare together that I can't handle.]


---
## 5. Real-World Example
Describe a real application and which database approach would be best:
**Application:** [e.g., Social media app, online shop, etc.]

**Best Choice:** [SQL/NoSQL/Hybrid]

**Reasoning:** [I'm not too sure to be honest. I don't know anything about Hybrid. So I can't compare them all]


---
## Reflection Questions
1. **What surprised you most about ORMs?**
[It breaks my brains into pieces, it quite similar like OOP but is an upgrade (so much complicated than OOP)]

2. **Can you think of a situation where NoSQL would be better than SQL?**
[I'm not sure]

3. **For a school project, which would you chhoose and why?**
[I would choose SQL, I think it's useful and easy to use?]