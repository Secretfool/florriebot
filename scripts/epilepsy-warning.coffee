# Description:
#   Warn about epilepsy
#
# Commands:

module.exports = (robot) ->
  robot.hear /(?:strobe|epilepsy|epilepsie)/i, (msg) ->
    
    if Math.random() <= 0.05
      msg.send "Warning! http://silviolorusso.com/wp-content/uploads/2013/09/epilepsy-warning.gif"
      
    msg.send "WARNING! http://blogfiles.wfmu.org/KF/2012/12/19/epilepsy_warning.gif"
