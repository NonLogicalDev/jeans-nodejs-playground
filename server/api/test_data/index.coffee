Route = (require 'express').Router()

console.log "sadfasdfasdfasd"
cow = '''
  _________________________________________
/ Hacking's just another word for nothing \\
\\ left to kludge.                         /
   -----------------------------------------
        \\   ^__^
         \\  (oo)\\_______
            (__)\\       )\\/\\
                ||----w |
                ||     ||
'''

Route.get '/', (req, res) ->
  res.json [
    message: "I am the data from the service YIPPIII!"
  ,
    message: "I don't mean to be so exited."
  ,
    message: "But somehow I am..."
  ,
    message: cow
  ]

module.exports = Route

