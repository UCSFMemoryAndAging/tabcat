           
# The flanker block runs a set number of trials
# (randomly ordered) and each trial has the following structure:
# 1) Pre Trial Delay: 0.2 seconds in the real testing and 0.4 seconds
# in the practice blocks
# 2) Fixation Period: displays fixation stimuli for at least 1 second and
# no more than 3 seconds (random)
# 3) Stimuli Display: displays the trial stimuli for 4 seconds or until the
# subject provides a keyboard response
# 4) Feedback Display: in practice trials, displays feedback to the subject
# about their response for 2 seconds
# 5) Records response


TEST_TRIALS = [
  {'congruent':0, 'arrows':'llrll', 'upDown':'up'  , 'corrAns':'right'},
  {'congruent':1, 'arrows':'lllll', 'upDown':'down', 'corrAns':'left' },
  {'congruent':2, 'arrows':'rrlrr', 'upDown':'up'  , 'corrAns':'left' },
]

DEFAULT_TRIALS = [
  {'congruent':0, 'arrows':'llrll', 'upDown':'up'  , 'corrAns':'right'},
  {'congruent':1, 'arrows':'lllll', 'upDown':'down', 'corrAns':'left' },
  {'congruent':0, 'arrows':'rrlrr', 'upDown':'up'  , 'corrAns':'left' },
  {'congruent':1, 'arrows':'rrrrr', 'upDown':'down', 'corrAns':'right'},
  {'congruent':0, 'arrows':'llrll', 'upDown':'down', 'corrAns':'right'},
  {'congruent':1, 'arrows':'lllll', 'upDown':'up'  , 'corrAns':'left' },
  {'congruent':0, 'arrows':'rrlrr', 'upDown':'down', 'corrAns':'left' },
  {'congruent':1, 'arrows':'rrrrr', 'upDown':'up'  , 'corrAns':'right'},
]

# pre trial delay of 0.4 seconds in practice blocks
# (time between response and next fixation)
PRACTICE_PRE_TRIAL_DELAY = 4000

# In practice trials, feedback is displayed to subject
# about their responses for 2 seconds
PRACTICE_FEEDBACK_DISPLAY_DURATION = 2000

# If the subject gets 6 out of 8 trials correct in a practice trial then
# skip ahead to the real testing trial. If the subject fails to get
# 6 out of 8 in 3 practice blocks then end the task.
PRACTICE_MAX_STREAK = 6

# Displays fixation stimuli for at least 1 second and
# no more than 3 seconds (random)
FIXATION_PERIOD_MIN = 1000
FIXATION_PERIOD_MAX = 3000

# pre trial delay of 0.2 seconds in real testing
# (time between response and next fixation)
PRE_TRIAL_DELAY = 200

# trial stimuli is displayed for 4 seconds or until subject
# provides a keyboard response
STIMULI_DISPLAY_DURATION = 4000

# main div's aspect ratio (pretend we're on an iPad)
ASPECT_RATIO = 4/3

TrialHandler = class

  constructor: (@numReps = 1, @trialList = DEFAULT_TRIALS) ->
    @numReps = Math.max(1, @numReps)
    @trialListLength = @trialList.length
    @currentRepNum = 0
    @currentTrialNum = -1
    @currentTrial = {}
    @finished = false
    @sequenceIndices = @createSequence()
    
  createSequence: ->
    trialListIndices = _.range @trialListLength
    (_.shuffle trialListIndices for i in [0...@numReps])

  getSequence: ->
    @sequenceIndices

  next: ->
    @currentTrialNum += 1
    if @currentTrialNum is @trialListLength
      @currentTrialNum = 0
      @currentRepNum += 1
    if @currentRepNum >= @numReps
      @finished = true

    if @finished
      @currentTrial = {}
      false
    else
      index = @sequenceIndices[@currentRepNum][@currentTrialNum]
      @currentTrial = @trialList[index]
      

practiceBlock1 = new TrialHandler(1)
practiceBlock2 = new TrialHandler(1)
practiceBlock3 = new TrialHandler(1)
testingBlock = new TrialHandler(2)

currentBlock = practiceBlock1
practiceMode = true


showArrow = (arrows, upDown) ->
  $arrow = $('#'+arrows+'_'+upDown)
  $arrow.show()

hideFeedback = ->
  $feedback = $('#feedback')
  $feedback.hide()

showFeedback = (correct) ->
  msg = if correct then "Correct!" else "Incorrect"
  $feedback = $('#feedback').text(msg)
  $feedback.show()

showNextTrial = ->
  clearStimuli()
  $('#fixation').show()
  
  TabCAT.UI.wait(_.random(FIXATION_PERIOD_MIN, FIXATION_PERIOD_MAX)).then(->
    trial = currentBlock.next()
    $arrow = $('#' + trial.arrows + '_' + trial.upDown)
    $arrow.show()
  )

preTrialDelay = ->
  if practiceMode
    TabCAT.UI.wait(PRACTICE_PRE_TRIAL_DELAY).then(-> return)
  else
    TabCAT.UI.wait(PRE_TRIAL_DELAY).then(-> return)
  
next = ->
  preTrialDelay()
  showNextTrial()

clearStimuli = ->
  $stimuli = $('#stimuli')
  $stimuli.children().hide()

showBeginButton = ->
  $('#beginButton').show()

hideBeginButton = ->
  $('#beginButton').hide()
    
showResponseButtons = ->
  $('#leftResponseButton, #rightResponseButton').show()

hideResponseButtons = ->
  $('#leftResponseButton, #rightResponseButton').hide()

handleResponseTouchStart = (event) ->
  event.preventDefault()
  event.stopPropagation()
  
  clearStimuli()
  response = event.target.value.toLowerCase()
  currentTrial = currentBlock.currentTrial
  
  showFeedback(currentTrial.corrAns is response)

  TabCAT.UI.wait(PRACTICE_FEEDBACK_DISPLAY_DURATION).then(->
    clearStimuli()
    next()
  )

handleBeginClick = (event) ->
  hideBeginButton()
  showResponseButtons()
  clearStimuli()
  next()

# INSTRUCTIONS
showStartScreen = ->
  $intro = $('#stimuli')
  
  $beginButton = $('#beginButton')
  $beginButton.on('click', handleBeginClick)
  
  $responseButtons = $('#leftResponseButton, #rightResponseButton')
  $responseButtons.on('mousedown touchstart', handleResponseTouchStart)
  
  $intro.show()
  showBeginButton()

# INITIALIZATION
@initTask = ->
  TabCAT.Task.start(trackViewport: true)

  TabCAT.UI.turnOffBounce()
  TabCAT.UI.enableFastClick()

  $(->
    $rectangle = $('#rectangle')

    TabCAT.UI.fixAspectRatio($rectangle, ASPECT_RATIO)
    TabCAT.UI.linkEmToPercentOfHeight($rectangle)
    
    showStartScreen()
  )
