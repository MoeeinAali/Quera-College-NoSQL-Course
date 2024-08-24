use quera
db.createCollection("users")
db.users.insertMany([
{
  name: "Moein",
  university: "HNU",
  Company: "Quera",
  email: "moein@gmail.com",
  technologies: ["php", "laravel"],
},{
  name: "Matin",
  university: "IAU",
  Company: "Quera",
  email: "matin@gmail.com",
  technologies: ["python", "django","go","nosql"]},
{
  name: "younes",
  university: "SU",
  Company: "Quera",
  email: "youness@gmail.com",
  technologies: ["php", "laravel","GO","SQL"],
}]
)