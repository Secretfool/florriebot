# Description:
#   CHue
#
# Commands:
#   hubot chue alert [<lamp>] [<timeout>] - Blink hue lamps at CH for <timeout> milliseconds
#   hubot chue colour [<lamp>] #<hex> - Change hue lamp <lamp> (or all) to colour <hex>
#   hubot chue colourloop [<lamp>] - Set hue lamps on colourloop
#   hubot chue random [<lamp>] - Change hue lamps to a random colour
#   hubot chue strobe [<lamp>] [<timeout>] - Strobe hue lamps for <timeout> milliseconds
#   hubot bvoranje - B'voranje :owl:
#
# Configuration:
#   HUBOT_CHUE_URL = <scheme>://<host:port>/<basepath>/

module.exports = (robot) ->
  chueURL = process.env.HUBOT_CHUE_URL
  unless chueURL?
    robot.logger.error "Missing HUBOT_CHUE_URL in environment"
    return

  robot.respond /chue alert ?(\d)? ?(.*)?/i, (msg) ->
    lamp = if msg.match[1] is undefined then "all" else msg.match[1]
    timeout = if msg.match[2] is undefined then 5502 else msg.match[2]
    robot.http("#{chueURL}alert?timeout=#{timeout}")
        .get() (err, res, body) ->
            msg.emote "Blinking hue lamps at CH"

  robot.respond /chue random ?(\d)?/i, (msg) ->
    lamp = if msg.match[1] is undefined then "all" else msg.match[1]
    robot.http("#{chueURL}random/#{lamp}")
        .get() (err, res, body) ->
            msg.emote "Changed colour of hue lamps at CH to a random colour"

  robot.respond /chue colou?rloop ?(\d)?/i, (msg) ->
    lamp = if msg.match[1] is undefined then "all" else msg.match[1]
    robot.http("#{chueURL}colorloop/#{lamp}")
        .get() (err, res, body) ->
            msg.emote "Put on a colourloop at CH"
            
  robot.respond /chue strobe ?(\d)? ?(\d+)*/i, (msg) ->
    lamp = if msg.match[1] is undefined then "all" else msg.match[1]
    duration = if msg.match[2] is undefined then "" else "?duration=" + msg.match[2]
    robot.http("#{chueURL}strobe/#{lamp}" + duration)
        .get() (err, res, body) ->
            msg.emote "Flashed for every one at CH"

  robot.respond /chue colou?r (\d)? ?#?(.*)/i, (msg) ->
    lamp = if msg.match[1] is undefined then "all" else msg.match[1]
    colour = msg.match[2]

    robot.http("#{chueURL}color/#{lamp}/#{colour}")
        .get() (err, res, body) ->
            if res.statusCode == 200
              msg.emote body

  robot.respond /bvoranje/i, (msg) ->
    robot.http("#{chueURL}oranje")
        .get() (err, res, body) ->
            msg.emote ":owl:"
