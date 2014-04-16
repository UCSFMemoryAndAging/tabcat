###
Copyright (c) 2013, Regents of the University of California
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

  1. Redistributions of source code must retain the above copyright
  notice, this list of conditions and the following disclaimer.
  2. Redistributions in binary form must reproduce the above copyright
  notice, this list of conditions and the following disclaimer in the
  documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
###

# main div's aspect ratio (pretend we're on an iPad)
ASPECT_RATIO = 4/3

# the minimum number of target stars to show
MIN_TARGET_STARS = 1

# the maximum number of target stars to show
MAX_TARGET_STARS = 5

# maximum number of times we can randomly fail to place a target star
# before restarting the process
MAX_TARGET_STAR_FAILURES = 5

# maximum number of times we can randomly fail to place a test star
# before restarting the process
MAX_TEST_STAR_FAILURES = 20

# target stars' centers can never be less than this many star diameters apart
MIN_TARGET_STAR_DISTANCE = 6

# Distances test stars should be from target stars. They should
# also be at least this far from any other target stars and any stars
# currently displayed
DISTRACTOR_STAR_DISTANCES = [4.5, 4.5]

# how many star diameters high the sky div is
SKY_HEIGHT = 15

# how many star diameters wide the sky div is
SKY_WIDTH = SKY_HEIGHT * ASPECT_RATIO

# stars' centers should be at least this many star diameters from the
# edges of the sky div. This isn't actual CSS, but it works the same way
#
# leaving a larger margin at the top leaves space for the
# "which star did you just see?" message, and keeps us away from the
# status bar
SKY_TOP = 4
SKY_BOTTOM = SKY_HEIGHT - 2.5
SKY_LEFT = 2.5
SKY_RIGHT = SKY_WIDTH - 2.5

# path for the star image
STAR_IMG_PATH = 'img/star.png'

# how many star diameters the star image file is
# (the star fades smoothly, so this is kind of a judgment call).
# the star's <img> element also serves as its target area for touch events
STAR_IMG_WIDTH = STAR_IMG_HEIGHT = 1.6

# make sure test stars' target areas can't touch
MIN_TEST_STAR_DISTANCE = Math.sqrt(
  STAR_IMG_WIDTH * STAR_IMG_WIDTH + STAR_IMG_HEIGHT * STAR_IMG_HEIGHT)

# path for the comet image
COMET_IMG_PATH = 'img/comet.png'

# size of the comet, in star diameters
COMET_IMG_HEIGHT = 3
COMET_IMG_WIDTH = COMET_IMG_HEIGHT * 368 / 118

# minimum y-coordinate for top of screen, in star coordinates
# (it can't be any less than this because we don't allow portrait mode)
SCREEN_MIN_Y = Math.min(0, (SKY_HEIGHT - SKY_WIDTH) / 2)

# max y-coordinate for bottom of screen, in star coordinates
SCREEN_MAX_Y = Math.max(SKY_HEIGHT, SCREEN_MIN_Y + SKY_WIDTH)

# start y-coordinate for comet centers, just above the screen
# (in theory, we should use the length of the diagonal of the comet,
# but in practice, that part of the image is transparent anyway)
COMET_START_Y = SCREEN_MIN_Y - COMET_IMG_WIDTH / 2

# end y-coordinate for comet centers, just below the screen
COMET_END_Y = SCREEN_MAX_Y + COMET_IMG_WIDTH / 2

# number of comets
NUM_COMETS = 3

# length of comets, in star diameters. This corresponds to the comet
# image's width.
COMET_LENGTHS = [11, 5, 7]

# aspect ratio of comet image. Divide image width by this to get height.
COMET_IMG_ASPECT_RATIO = 736 / 236

# start and end time for each of the three comets
COMET_TIMINGS = [[0, 4000], [1000, 2000], [2000, 4000]]

# start and end x ranges for comets. Multiply these by SKY_WIDTH to get
# star coordinates. These are chosen so that the first and second comet
# don't overlap.
#
# Half the time (randomly), the coordinates of all comets will be flipped
# around the middle of the screen.
COMET_X_RANGES = [
  [[-0.1, 0.3], [0.2, 1.5]],
  [[0.4, 1.2], [-0.2, 0.7]],
  [[0.2, 0.8], [-0.1, 1.1]],
]

# how long to show comets. This matches the CSS for #cometSky div.msg
# in css/task.css
COMET_TIME_LIMIT = 5000

# how tall the score font is, as percentage of sky height
SCORE_FONT_SIZE = 12

# height of the score div, as percentage of sky height
SCORE_HEIGHT = 16

# how long to show the score after tapping a comet
SCORE_DURATION = 1000

# how long a fade in should take, in msec
FADE_DURATION = 400

# how long to display target stars (not including fades)
TARGET_STAR_DURATION = 3000

# how long to display target stars in practice mode
TARGET_STAR_PRACTICE_DURATION = 5000

# how many reversals before we stop
MAX_REVERSALS = 18

# how many comets do you have to catch before we show stars?
MIN_COMETS_CAUGHT_BEFORE_STARS_SHOWN = 3

# intensities in practice mode, based on how many the patient got correct
# so far. We want them to get one star right twice, and two stars right
# twice, before going on to the real trial.
PRACTICE_MODE_INTENSITIES = [-1, -1, -2, -2]

# initial static "staircase" for the real trial
staircase = new TabCAT.Task.Staircase(
  intensity: -2
  minIntensity: -MAX_TARGET_STARS
  maxIntensity: -MIN_TARGET_STARS
  stepsUp: 2
  stepsDown: 1
)

# use this to turn off comets, for faster debugging
DEBUG_NO_COMETS = false

# if comets are turned off, turn screen black for this long instead
DEBUG_DELAY_INSTEAD_OF_COMETS = 1000

# set this to always show the same number of stars
DEBUG_NUM_STARS = null

# don't hide the target stars when showing test stars
DEBUG_KEEP_TARGET_STARS_VISIBLE = false

# skip practice mode
DEBUG_SKIP_PRACTICE_MODE = false

# how many has the patient gotten correct in practice mode?
numCorrectInPractice = 0

# how many comets has the patient caught so far?
cometsCaught = 0



# are we in practice mode?
inPracticeMode = ->
  (numCorrectInPractice < PRACTICE_MODE_INTENSITIES.length \
    and not DEBUG_SKIP_PRACTICE_MODE)


# the current intensity. Use this instead of staircase.instensity;
# it accounts for practice mode.
getIntensity = ->
  if DEBUG_NUM_STARS? and DEBUG_NUM_STARS > 0
    -DEBUG_NUM_STARS
  else if inPracticeMode()
    PRACTICE_MODE_INTENSITIES[numCorrectInPractice]
  else
    staircase.intensity


# how long to show target stars?
getTargetStarDuration = ->
  if inPracticeMode()
    TARGET_STAR_PRACTICE_DURATION
  else
    TARGET_STAR_DURATION


# return x squared
sq = (x) ->
  x * x


# return the distance between two points, squared
distSq = ([x1, y1], [x2, y2]) ->
  sq(x2 - x1) + sq(y2 - y1)


# convert star x-coordinate/width to a % of sky width (for use in CSS)
starXToSky = (x) ->
  (100 * x / SKY_WIDTH) + '%'

# convert star y-coordinate/height to a % of sky height (for use in CSS)
starYToSky = (y) ->
  (100 * y / SKY_HEIGHT) + '%'


# helper for makeStarImg
makeImg = ([x, y], [width, height], attrs) ->
  $img = $('<img>')

  for own key, value of attrs
    $img.attr(key, value)

  $img.css(
    left: starXToSky(x - width / 2)
    top: starYToSky(y - height / 2)
  )

  $img.attr('width', starXToSky(width))
  $img.attr('height', starYToSky(height))

  return $img


# convert star center (in star coordinates) to an image tag
makeStarImg = ([x, y]) ->
  makeImg([x, y], [STAR_IMG_WIDTH, STAR_IMG_HEIGHT],
    class: 'star', src: STAR_IMG_PATH)



# used by untilSucceeds (below)
class Failure


# there's lots of space for stars, but it's possible to get into a state where
# we've randomly selected some of the stars and it's impossible to proceed, and
# we have to start the random selection process from the beginning.
#
# untilSucceeds() calls a function a certain number of times, and then raises
# Failure. It also gracefully handles Failure, allowing you to nest it.
#
# if maxFailures is null, tries forever
untilSucceeds = (f, maxFailures) ->
  numFailures = 0

  while true
    try
      return f()
    catch error
      if error not instanceof Failure
        throw error

    numFailures += 1
    if maxFailures? and numFailures > maxFailures
      throw new Failure


# pick coordinates for a star at random
pickStarInSky = ->
  # we're positioning centers of the stars and the padding specifies
  # edges, so make the range smaller by the stars' radius (0.5)
  [
    TabCAT.Math.randomUniform(SKY_LEFT, SKY_RIGHT)
    TabCAT.Math.randomUniform(SKY_TOP, SKY_BOTTOM)
  ]


# is the given star in the sky?
isInSky = ([x, y]) ->
  SKY_LEFT <= x <= SKY_RIGHT and SKY_TOP <= y <= SKY_BOTTOM


# Pick *n* target stars at random, and then pick 3 test stars
#
# We do these together because there are some target star configurations
# for which there are no valid test stars
#
# Each test star anchors on a different target star (chosen at random).
# The correct star *is* the same as its anchor, and the others are distractor
# stars, placed randomly a certain fixed distance from the anchor (see
# DISTRACTOR_STAR_DISTANCES). When there is no target star to anchor on
# (1 or 2 target stars), distractor stars are placed randomly anywhere
# in the sky.
pickTargetAndTestStars = (n) ->
  untilSucceeds(->
    targetStars = []
    testStars = []

    while targetStars.length < n
      targetStars.push(
        untilSucceeds(
          (-> nextTargetStar(targetStars)), MAX_TARGET_STAR_FAILURES))

    testStarDistances = [0].concat(DISTRACTOR_STAR_DISTANCES)

    anchors = _.sample(targetStars, testStarDistances.length)

    for distance, i in testStarDistances
      testStars.push(untilSucceeds(
        (-> nextTestStar(distance, anchors[i], targetStars, testStars)),
        MAX_TEST_STAR_FAILURES))

    return [targetStars, testStars]
  )


# return a target star that works with the existing stars, or undefined
nextTargetStar = (stars) ->
  candidateStar = pickStarInSky()
  if canAddTargetStar(candidateStar, stars)
    return candidateStar
  else
    throw new Failure


# is candidateStar not too close to other target stars?
canAddTargetStar = (candidateStar, stars) ->
  stars.length is 0 or not isCloserThanToAny(
    candidateStar, MIN_TARGET_STAR_DISTANCE, stars)


# return true if *candidateStar* is closer than *distance* to any of *stars*
isCloserThanToAny = (candidateStar, distance, stars) ->
  for star in stars
    if distSq(candidateStar, star) < sq(distance)
      return true
  return false


# pick a test star at the given distance from the given anchor,
# or throw Failure
nextTestStar = (distance, anchorStar, targetStars, testStars) ->
  otherStars = _.without(targetStars, anchorStar).concat(testStars)

  if anchorStar
    candidateStar = pickStarAtDistanceFrom(distance, anchorStar)
  else
    candidateStar = pickStarInSky()

  if (isInSky(candidateStar) and \
      not isCloserThanToAny(candidateStar, distance, otherStars) and \
      not isCloserThanToAny( \
        candidateStar, Math.max(MIN_TEST_STAR_DISTANCE, distance), testStars) \
      )
    return candidateStar
  else
    throw new Failure



# randomly pick a star that is the given distance from another star
#
# may return stars outside the sky! use isInSky()
pickStarAtDistanceFrom = (distance, [x, y]) ->
  angle = TabCAT.Math.randomUniform(0, 2 * Math.PI)
  return [x + Math.cos(angle) * distance, y + Math.sin(angle) * distance]


# pick start and end coordinates for comets
pickComets = ->
  comets = []

  # randomly choose whether to flip x coordinates of comets
  maybeFlip = _.sample([
    (x) -> x,
    (x) -> 1 - x
  ])

  for i in [0...NUM_COMETS]
    comet = {}
    comet.num = i
    comet.startX = maybeFlip(TabCAT.Math.randomUniform(
      COMET_X_RANGES[i][0]...)) * SKY_WIDTH
    comet.endX = maybeFlip(TabCAT.Math.randomUniform(
      COMET_X_RANGES[i][1]...)) * SKY_WIDTH
    comet.length = COMET_LENGTHS[i]
    # just using the width of the comet image here;
    # don't need to worry about the diagonal of the comet image
    # because its corners are transparent anyway
    comet.startY = SCREEN_MIN_Y - comet.length / 2
    comet.endY = SCREEN_MAX_Y + comet.length / 2
    [comet.startTime, comet.endTime] = COMET_TIMINGS[i]
    comet.angle = (
      -Math.atan2(comet.endX - comet.startX, comet.endY - comet.startY) /
       Math.PI * 180 + 90)

    comets.push(comet)

  return comets


# convert comet center and angle to an image
makeCometImg = (comet) ->
  $img = makeImg(
    [comet.startX, comet.startY],
    [comet.length, comet.length / COMET_IMG_ASPECT_RATIO],
    class: 'comet', src: COMET_IMG_PATH)
  $img.css(rotationCss(comet.angle))
  return $img


# Add a comet to #cometSky
#
# Takes the following callbacks:
#
# startCallback: called after comet is visible, but before animation
# caughtCallback: called once when comet is tapped on
# doneCallback: called when comet reaches end of its path
#
# caughtCallback takes the event as a single argument;
# use event.target to get at the comet img, and event.data to get *comet*
#
# startCallback and doneCallback take fake event objects that have
# target and data set similarly to the argument to caughtCallback
#
addCometToSky = (comet, startCallback, caughtCallback, doneCallback) ->
  $cometImg = makeCometImg(comet)
  $('#cometSky').append($cometImg)

  fakeEvent = {target: $cometImg[0], data: comet}

  if startCallback?
    startCallback(fakeEvent)

  $cometImg.one('mousedown touchstart', comet, (event) ->
    event.preventDefault()

    if caughtCallback?
      caughtCallback(event)
  )

  $cometImg.animate({
    left: starXToSky(comet.endX - COMET_IMG_WIDTH / 2),
    top: starYToSky(comet.endY - COMET_IMG_WIDTH / 2),
  }, {
    duration: comet.endTime - comet.startTime
    easing: 'linear'
    complete: ->
      # don't fire on comets that have been caught
      if $cometImg.is(':visible')
        if doneCallback?
          doneCallback(fakeEvent)
        $cometImg.remove()
  })

  return





# show stars to remember.
#
# This is also responsible for setting up star positions for the entire
# trial.
showTargetStars = ->
  $targetSky = $('#targetSky')
  $cometSky = $('#cometSky')
  $testSky = $('#testSky')

  $targetSky.hide()
  $cometSky.hide()
  $testSky.hide()

  # pick stars and set them up while message is being shown
  numTargetStars = -getIntensity()
  [targetStars, testStars] = pickTargetAndTestStars(numTargetStars)

  setUpTargetSky(targetStars)
  setUpTestSky(testStars)

  $targetSky.fadeIn(duration: FADE_DURATION)
  TabCAT.Task.logEvent(getTaskState())
  TabCAT.UI.wait(getTargetStarDuration()).then(showComets)

  return


# show comets to catch
showComets = ->
  $targetSky = $('#targetSky')
  $cometSky = $('#cometSky')

  if DEBUG_NO_COMETS
    if staircase.trialNum is 0
      staircase.trialNum += 1
      showTargetStars()
    else
      hideTargetSky()
      TabCAT.UI.wait(DEBUG_DELAY_INSTEAD_OF_COMETS).then(-> showTestStars())
    return

  $cometSky.hide()
  $cometSky.empty()

  TabCAT.UI.wait(COMET_TIME_LIMIT).then(->
    # first trial is comets only, and you must catch a certain number
    # of comets before continuing
    if staircase.trialNum is 0
      if cometsCaught >= MIN_COMETS_CAUGHT_BEFORE_STARS_SHOWN
        staircase.trialNum += 1
        showTargetStars()
      else
        showComets()
    else
      showTestStars()
  )

  $msg = $('<div></div>', class: 'msg')
  $msg.one('animationend webkitAnimationEnd', -> $msg.remove())
  if inPracticeMode()
    $msg.text('Tap to catch comets!')
  else
    $msg.text('Catch comets!')
  $cometSky.append($msg)

  $targetSky.hide()
  $cometSky.fadeIn(duration: FADE_DURATION)

  startComets()


# hide the target sky (debugging hook)
hideTargetSky = ->
  $targetSky = $('#targetSky')
  if DEBUG_KEEP_TARGET_STARS_VISIBLE
    $targetSky.find('.msg').hide()
    $targetSky.find('img').css(opacity: 0.3)
  else
    $targetSky.hide()


# helper for showComets()
startComets = (duration) ->

  comets = pickComets()

  startCallback = -> TabCAT.Task.logEvent(getTaskState(), 'addComet')

  # add feedback for comet being caught
  caughtCallback = (event) ->
    comet = event.data
    interpretation =
      caughtComet:
        num: comet.num
        length: comet.length

    TabCAT.Task.logEvent(getTaskState(), event, interpretation)

    # cometsCaught will be incremented in the *next* event, for consistency
    # with intensity
    cometsCaught += 1
    $(event.target).remove()

    if event.type is 'mousedown'
      touch = event
    else
      touch = event.originalEvent.changedTouches[0]

    showScore(touch.pageX, touch.pageY, cometsCaught)

  for comet in comets
    do (comet) ->
      TabCAT.UI.wait(comet.startTime).then(->
        addCometToSky(comet, startCallback, caughtCallback))


# add a score centered on the given coordinates on the screen
showScore = (pageX, pageY, amount) ->
  $rectangle = $('#rectangle')
  {left: skyLeft, top: skyTop} = $rectangle.offset()
  skyWidth = $rectangle.width()
  skyHeight = $rectangle.height()

  # express location of click in terms of percentage inside sky
  xPct = (pageX - skyLeft) / skyWidth * 100
  yPct = (pageY - skyTop) / skyHeight * 100

  $scoreDiv = $('<div></div>', class: 'score')
  $scoreDiv.text(amount)
  $scoreDiv.one('animationend webkitAnimationEnd', -> $scoreDiv.remove())

  $scoreDiv.css(
    top: (yPct - (SCORE_HEIGHT / 2)) + '%'
    left: (xPct - 50) + '%'
    width: '100%'
    height: SCORE_HEIGHT + '%'
    'font-size': SCORE_FONT_SIZE + 'em'
  )

  # don't show two scores at once
  $rectangle.find('div.score').remove()

  $rectangle.append($scoreDiv)

  # just in case animations are broken
  TabCAT.UI.wait(SCORE_DURATION).then(-> $scoreDiv.remove())

  return


# show star(s) to match against the target stars
showTestStars = ->
  $cometSky = $('#cometSky')
  $testSky = $('#testSky')

  hideTargetSky()
  $cometSky.hide()
  $testSky.fadeIn(duration: FADE_DURATION)



# set up the #targetSky div. Not responsible for hiding/showing it
setUpTargetSky = (targetStars) ->
  $targetSky = $('#targetSky')

  $targetSky.empty()
  for targetStar in targetStars
    $targetSky.append(makeStarImg(targetStar))

  $msg = $('<div></div>', class: 'msg')
  if inPracticeMode()
    if -getIntensity() is 1
      $msg.text('Remember where this star is')
    else if -getIntensity() is 2
      $msg.html('Remember <em>both</em> stars')
    else
      # we currently don't use this except for debugging
      $msg.html('Remember <em>all</em> these stars')
  else
    $msg.text('Remember')
  $targetSky.append($msg)


# set up the #testSky div, including the "which star did you just see?"
# message. Not responsible for hiding/showing it
setUpTestSky = (testStars) ->
  $testSky = $('#testSky')

  $testSky.empty()

  for testStar, i in testStars
    correct = i is 0
    $testStarImg = makeStarImg(testStar)
    $testStarImg.one('mousedown touchstart', correct, (event) ->
      event.preventDefault()
      correct = event.data

      state = getTaskState()  # do this before addResult()!
      interpretation = staircase.addResult(correct, noChange: inPracticeMode())

      TabCAT.Task.logEvent(state, event, interpretation)

      if inPracticeMode() and correct
        numCorrectInPractice += 1

      if not inPracticeMode() and staircase.numReversals >= MAX_REVERSALS
        TabCAT.Task.finish()
      else
        showTargetStars()
    )
    $testSky.append($testStarImg)

    $msg = $('<div></div>', class: 'msg')
    if -getIntensity() is 1
      $msg.text('Which star did you just see?')
    else
      $msg.html('Which <em>one</em> did you just see?')
    $testSky.append($msg)


# summary of the current state of the task
getTaskState = ->
  state =
    cometsCaught: cometsCaught
    intensity: getIntensity()
    stimuli: getStimuli()
    trialNum: staircase.trialNum

  if inPracticeMode()
    state.practiceMode = true

  return state


# describe what's on the screen. helper for getTaskState()
getStimuli = ->
  skyIdToKey =
    targetSky: 'targetStars'
    testSky: 'testStars'

  stimuli = {}

  for own id, key of skyIdToKey
    $sky = $('#' + id)
    stars = (
      TabCAT.Task.getElementBounds(img) for img in $sky.find('img:visible'))
    if stars.length
      stimuli[key] = stars

  $comets = $('img.comet:visible')
  if $comets.length
    stimuli['comets'] = (
      $(comet).css(['top', 'left', 'width', 'height', 'transform']) \
      for comet in $comets)

  return stimuli


catchStrayTouchStart = (event) ->
  event.preventDefault()
  TabCAT.Task.logEvent(getTaskState(), event)


# TODO: use $.cssHooks instead
rotationCss = (angle) ->
  if angle == 0
    return {}

  value = 'rotate(' + angle + 'deg)'
  return {
    transform: value
    '-moz-transform': value
    '-ms-transform': value
    '-o-transform': value
    '-webkit-transform': value
  }

showStartScreen = ->
  $startScreen = $('#startScreen')

  $startScreen.find('button').on('click', ->
    $startScreen.hide()
    $('body').removeClass('blueBackground')
    showComets()
  )

  $startScreen.show()


# INITIALIZATION
@initTask = ->
  TabCAT.Task.start(trackViewport: true)

  TabCAT.UI.turnOffBounce()
  TabCAT.UI.enableFastClick()

  $(->
    if DEBUG_NO_COMETS
      $('.catch-comets').css('text-decoration': 'line-through')

    $task = $('#task')
    $rectangle = $('#rectangle')

    TabCAT.UI.requireLandscapeMode($task)
    $task.on('mousedown touchstart', catchStrayTouchStart)

    TabCAT.UI.fixAspectRatio($rectangle, ASPECT_RATIO)
    TabCAT.UI.linkEmToPercentOfHeight($rectangle)

    showStartScreen()
  )
