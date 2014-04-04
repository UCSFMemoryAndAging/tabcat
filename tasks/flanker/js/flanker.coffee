
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

translations =
  en:
    translation:
      practice_html:
        '<p>You will be shown a series of arrows on the screen, ' +
        'pointing to the left or to the right. For example:</p>' +
        '<img width="100" height="100" src="img/rrrrr.bmp"/>' +
        '<p>or</p>' +
        '<img width="100" height="100" src="img/llrll.bmp"/>' +
        '<p>Press the RIGHT button if the CENTER arrow ' +
        'points to the right.</p>' +
        '<p>Press the LEFT button if the CENTER arrow ' +
        'points to the left.</p>' +
        '<p>Try to respond as quickly and accurately as you can.</p>' +
        '<p>Try to keep your attention focused on the ' +
        'cross ("+") at the center of the screen.</p>' +
        '<p>First we\'ll do a practice trial.</p>'
      additional_practice_html:
        '<p>You have completed the practice trial. ' +
        'Let\'s do another practice trial.</p>' +
        '<p>You will be shown a series of arrows on the screen, ' +
        'pointing to the left or to the right. For example:</p>' +
        '<img width="100" height="100" src="img/rrrrr.bmp"/>' +
        '<p>or</p>' +
        '<img width="100" height="100" src="img/llrll.bmp"/>' +
        '<p>Press the RIGHT button if the CENTER arrow ' +
        'points to the right.</p>' +
        '<p>Press the LEFT button if the CENTER arrow ' +
        'points to the left.</p>' +
        '<p>Try to respond as quickly and accurately as you can.</p>' +
        '<p>Try to keep your attention focused on the ' +
        'cross ("+") at the center of the screen.</p>'
      testing_html:
        '<p>Now we\'ll move on to the task, the instructions are the same ' +
        'except you will no longer receive feedback after your responses.</p>' +
        '<br/>' +
        '<p>Press the LEFT button if the CENTER arrow ' +
        'points to the left.</p>' +
        '<p>Press the RIGHT button if the CENTER arrow ' +
        'points to the right.</p>' +
        '<br/>' +
        '<p>Remember to keep your focus on the center cross ("+") and try to ' +
        'respond as quickly as possible without making mistakes.</p>' +
        '<br/>' +
        '<p>Tap the "Begin" button when you are ready to begin.</p>'
      complete_html:
        '<p>The task is complete.</p>'
      feedback_correct_html:
        'Correct!'
      feedback_incorrect_html:
        'Incorrect.'
      feedback_no_response_html:
        'No response detected.'

TEST_TRIALS = [
  {'congruent':0, 'arrows':'lllll', 'upDown':'up'  , 'corrAns':'left'},
  {'congruent':1, 'arrows':'rrrrr', 'upDown':'down', 'corrAns':'right' },
  {'congruent':2, 'arrows':'llrll', 'upDown':'up'  , 'corrAns':'right' },
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
PRACTICE_PRE_TRIAL_DELAY = 4

# In practice trials, feedback is displayed to subject
# about their responses for 2 seconds
PRACTICE_FEEDBACK_DISPLAY_DURATION = 200

# If the subject gets 6 out of 8 trials correct in a practice trial then
# skip ahead to the real testing trial. If the subject fails to get
# 6 out of 8 in 3 practice blocks then end the task.
PRACTICE_MIN_CORRECT = 2

# Max number of practice blocks to try before aborting task
PRACTICE_MAX_BLOCKS = 3

# Displays fixation stimuli for at least 1 second and
# no more than 3 seconds (random)
FIXATION_PERIOD_MIN = 100
FIXATION_PERIOD_MAX = 300

# pre trial delay of 0.2 seconds in real testing
# (time between response and next fixation)
PRE_TRIAL_DELAY = 20

# trial stimuli is displayed for 4 seconds or until subject
# provides a keyboard response
STIMULI_DISPLAY_DURATION = 4000

# main div's aspect ratio (pretend we're on an iPad)
ASPECT_RATIO = 4/3

# how many has the patient gotten correct in practice block?
numCorrectInPractice = 0

# which practice block are we on
numPracticeBlocks = 1

# have we passed the practice yet?
practicePassed = ->
  (numPracticeBlocks <= PRACTICE_MAX_BLOCKS \
    and numCorrectInPractice >= PRACTICE_MIN_CORRECT)

# start off in practice mode
inPracticeMode = true

currentTrial = false

pp = (msg) ->
  $('#debug').html(JSON.stringify(msg))

TrialHandler = class

  constructor: (@numReps = 1, @trialList = TEST_TRIALS) ->
    @numReps = Math.max(1, @numReps)
    @trialListLength = @trialList.length
    @reset()
    
  reset: ->
    @currentRepNum = 0
    @currentTrialNum = -1
    @currentTrial = false
    @finished = false

    @sequenceIndices = @createSequence()
    
  createSequence: ->
    trialListIndices = _.range @trialListLength
    (_.shuffle trialListIndices for i in [0...@numReps])

  getSequence: ->
    @sequenceIndices

  hasNext: ->
    not @end()
  
  end: ->
    (@currentRepNum is (@numReps-1) \
      and @currentTrialNum is (@trialListLength-1))

  next: ->
    @currentTrialNum += 1
    
    if @currentTrialNum is @trialListLength
      @currentTrialNum = 0
      @currentRepNum += 1
      
    if @currentRepNum >= @numReps
      @finished = true

    if @finished
      @currentTrial = false
    else
      index = @sequenceIndices[@currentRepNum][@currentTrialNum]
      @currentTrial = @trialList[index]
    
  pp: ->
    pp(JSON.stringify(@sequenceIndices))
    
  ppCurrentState: ->
    pp("currentTrialNum: " + JSON.stringify(@currentTrialNum))

PRACTICE_BLOCK = new TrialHandler(1)
TESTING_BLOCK = new TrialHandler(2)

#PRACTICE_BLOCK.pp()
#TESTING_BLOCK.pp()


showArrow = (arrows, upDown) ->
  $arrow = $('#'+arrows+'_'+upDown)
  $arrow.show()

clearStimuli = ->
  $stimuli = $('#stimuli')
  $stimuli.children().hide()

showBeginButton = ->
  hideResponseButtons()
  $('#beginButton').show()

hideBeginButton = ->
  $('#beginButton').hide()
    
showResponseButtons = ->
  hideBeginButton()
  $('#leftResponseButton, #rightResponseButton').show()

hideResponseButtons = ->
  $('#leftResponseButton, #rightResponseButton').hide()
  
showInstructions = (translation) ->
  clearStimuli()
  $instructions = $('#instructions')
  $instructions.html($.t(translation))
  $instructions.show()

showFeedback = (translation) ->
  $feedback = $('#feedback')
  $feedback.html($.t(translation))
  $feedback.show()

hideFeedback = ->
  $feedback = $('#feedback')
  $feedback.hide()

showCurrentTrial = ->
  clearStimuli()
  $('#fixation').show()

  TabCAT.UI.wait(_.random(FIXATION_PERIOD_MIN, FIXATION_PERIOD_MAX)).then(->
    $arrow = $('#' + currentTrial.arrows + '_' + currentTrial.upDown)
    $arrow.show()
    #TabCAT.UI.wait(STIMULI_DISPLAY_DURATION).then(->
      #$arrow.hide()
      #showFeedback 'feedback_no_response_html'
    #)
  )

next = ->
  if inPracticeMode
    if PRACTICE_BLOCK.hasNext()
      currentTrial = PRACTICE_BLOCK.next()
      showCurrentTrial()
    else
      if numPracticeBlocks is PRACTICE_MAX_BLOCKS # failed all 3 practices
        showInstructions 'complete_html'
      else # start new practice block
        PRACTICE_BLOCK.reset()
        numCorrectInPractice = 0
        numPracticeBlocks += 1
        showInstructions 'additional_practice_html'
        showBeginButton()
  else
    if TESTING_BLOCK.hasNext()
      currentTrial = TESTING_BLOCK.next()
      showCurrentTrial()
    else # end of testing block
      showInstructions 'complete_html'

handleResponseTouchStart = (event) ->
  event.preventDefault()
  event.stopPropagation()
  
  clearStimuli()
  response = event.target.value.toLowerCase()
  correct = currentTrial.corrAns is response
  
  if inPracticeMode
    if correct
      numCorrectInPractice += 1
      showFeedback 'feedback_correct_html'
    else
      showFeedback 'feedback_incorrect_html'
      
    TabCAT.UI.wait(PRACTICE_FEEDBACK_DISPLAY_DURATION).then(->
      hideFeedback()
      
      if PRACTICE_BLOCK.end() and practicePassed()
        inPracticeMode = false
        showInstructions 'testing_html'
        showBeginButton()
      else
        TabCAT.UI.wait(PRACTICE_PRE_TRIAL_DELAY).then(->
          next()
        )
    )
  else # in testing block
    TabCAT.UI.wait(PRE_TRIAL_DELAY).then(->
      next()
    )

  #pp(JSON.stringify(numPracticeBlocks) + ' | ' + \
    #JSON.stringify(numCorrectInPractice) + ' | ' +
    #PRACTICE_BLOCK.getSequence())


handleBeginClick = (event) ->
  showResponseButtons()
  next()

# INSTRUCTIONS
showStartScreen = ->
  $beginButton = $('#beginButton')
  $beginButton.on('click', handleBeginClick)
  
  $responseButtons = $('#leftResponseButton, #rightResponseButton')
  $responseButtons.on('mousedown touchstart', handleResponseTouchStart)

  showInstructions 'practice_html'
  showBeginButton()

# INITIALIZATION
@initTask = ->
  TabCAT.Task.start(
    i18n:
      resStore: translations
    trackViewport: true
  )
  TabCAT.UI.turnOffBounce()
  TabCAT.UI.enableFastClick()
  
  $.i18n.init(resStore: translations, fallbackLng: 'en')

  $(->
    $rectangle = $('#rectangle')

    TabCAT.UI.fixAspectRatio($rectangle, ASPECT_RATIO)
    TabCAT.UI.linkEmToPercentOfHeight($rectangle)
    
    showStartScreen()
  )

