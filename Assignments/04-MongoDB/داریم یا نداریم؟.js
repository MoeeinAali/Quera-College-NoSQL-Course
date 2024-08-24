use quera;
db.createCollection("users");
db.users.find({
  technologies: { $in: ["php", "laravel"] }
});
