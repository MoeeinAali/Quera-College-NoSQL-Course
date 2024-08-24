use quera
db.techs.updateMany(
  { technologies: "python" },  
  {
    $set: {
      technologies: ["python"], 
      version: "3.12.0",  
      usage: ["backend", "AI", "DataAnalytics"]  
    }
  },
  { upsert: true } 
)
