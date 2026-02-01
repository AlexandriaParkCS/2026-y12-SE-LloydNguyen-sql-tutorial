# lesson10_orm_demo.py
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
        return f"<Character(name='{self.name}', species='{self.species}')>"

#Define Planet model   
class Planet(Base):
    __tablename__ = 'planets'

    id = Column(Integer, primary_key=True)
    name = Column(String, nullable=False)
    climate = Column(String)
    population = Column(Integer) 

    #Relationship to Character
    characters = relationship("Character", back_populates="homeworld")

    def __repr__(self):
        return f"<Planet(name='{self.name}')>"

# Connect to database
engine = create_engine('sqlite:///../runtime/db/starwars.db')
Session = sessionmaker(bind=engine)
session = Session()

# Query examples
print("=== ORM Query Examples ===\n")

# 1. Get all characters
print("1. All characters: ")
characters = session.query(Character).all()
for char in characters[:3]: # Show first 3
    print(f"  - {char.name} ({char.species})")

# 2. Fulter by species
print("\n2. Human characters:")
humans = session.query(Character).filter_by(species='Human').all()
for human in humans[:3]:
    print(f"  - {human.name}")

# 3. Order and limit
print("\n3. Three tallest characters:")
tallest = session.query(Character)\
    .filter(Character.height.isnot(None))\
    .order_by(Character.height.desc())\
    .limit(3)\
    .all()
for char in tallest:
    print(f"  - {char.name}: {char.height}cm")

# 4. Join (automatic with relationship!)
print("\n4. Characters with their homeworlds: ")
chars_with_planets = session.query(Character)\
    .join(Planet)\
    .filter(Planet.name == 'Tatooine')\
    .all()
for char in chars_with_planets:
    print(f"  - {char.name} from {char.homeworld.name}")

# 5. Aggregate functions
from sqlalchemy import func 
print("\n5. Statistics: ")
avg_height = session.query(func.avg(Character.height)).scalar()
char_count = session.query(func.count(Character.id)).scalar()
print(f"  - Average height: {avg_height:.1f}cm")
print(f"  - Total characters: {char_count}") 

session.close()