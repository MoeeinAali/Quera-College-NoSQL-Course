use quera;
db.createCollection("users");
db.users.find(
  { age: { $lte: 25 } }, 
  { _id: 0, technologies: 1 }  
);
