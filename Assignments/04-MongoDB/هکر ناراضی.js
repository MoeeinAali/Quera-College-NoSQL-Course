use quera
db.users.drop()
db.techs.drop()
db.hacked.insertOne({
  hacked_by: "me!"
})
