           
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
PRACTICE_PRE_TRIAL_DELAY = 400

# In practice trials, feedback is displayed to subject
# about their responses for 2 seconds
PRACTICE_FEEDBACK_DISPLAY_DURATION = 2000

# If the subject gets 6 out of 8 trials correct in a practice trial then
# skip ahead to the real testing trial. If the subject fails to get
# 6 out of 8 in 3 practice blocks then end the task.
PRACTICE_MAX_STREAK = 6

# pre trial delay of 0.2 seconds in real testing
PRE_TRIAL_DELAY = 200

# trial stimuli is displayed for 4 seconds or until subject
# provides a keyboard response
STIMULI_DISPLAY_DURATION = 4000

# main div's aspect ratio (pretend we're on an iPad)
ASPECT_RATIO = 4/3

# INITIALIZATION
@initTask = ->

  test = new TrialHandler(TEST_TRIALS,3)
  alert test.getSequence()
  for i in [0...9]
    alert JSON.stringify test.next()

  #TabCAT.Task.start(trackViewport: true)

  #TabCAT.UI.turnOffBounce()
  #TabCAT.UI.enableFastClick()

  $(->
    $rectangle = $('#rectangle')

    TabCAT.UI.fixAspectRatio($rectangle, ASPECT_RATIO)
    TabCAT.UI.linkEmToPercentOfHeight($rectangle)
    
    showStartScreen()
  )
  
  
TrialHandler = class

  constructor: (@trialList, @numReps = 1) ->
    @numReps = if @numReps < 0 then 1 else @numReps
    @trialListLength = @trialList.length
    @currentRepNum = 0
    @currentTrialNum = -1
    @finished = false
    @sequenceIndices = @createSequence()

    
  createSequence: ->
    trialListIndices = _.range @trialListLength
    rep = @numReps + 1
    @sequenceIndices = (_.shuffle trialListIndices while rep -= 1)

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
      false
    else
      index = @sequenceIndices[@currentRepNum][@currentTrialNum]
      @trialList[index]

  
# INSTRUCTIONS
showStartScreen = ->

  $intro = $('#stimuli')
  $beginButton = $('#beginButton')

  $beginButton.on('click', ->
    $intro.children().hide()
    hideBeginButton()
    showArrow('rrlrr','down')
    showArrow('rrlrr','up')
    $('#fixation').show()
    showResponseButtons()
  )
  
  $intro.show()
  showBeginButton()

showBeginButton = ->
  $('#beginButton').show()

hideBeginButton = ->
  $('#beginButton').hide()
    
showResponseButtons = ->
  $('#leftResponseButton, #rightResponseButton').show()

hideResponseButtons = ->
  $('#leftResponseButton, #rightResponseButton').hide()

showArrow = (arrows, upDown) ->
  $arrow = $('#'+arrows+'_'+upDown)
  $arrow.show()



