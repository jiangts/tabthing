express = require("express")
router = express.Router()

# GET home page. 
router.get "/", (req, res) ->
  res.render "sections",
    title: "Express"

module.exports = router
