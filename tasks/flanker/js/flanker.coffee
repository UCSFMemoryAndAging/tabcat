


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
        'testing'
      complete_html:
        'The task is complete.'
      feedback_correct_html:
        'Correct!'
      feedback_incorrect_html:
        'Incorrect.'
      feedback_no_response_html:
        'No response detected.'

           
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
PRACTICE_PRE_TRIAL_DELAY = 400

# In practice trials, feedback is displayed to subject
# about their responses for 2 seconds
PRACTICE_FEEDBACK_DISPLAY_DURATION = 2000

# If the subject gets 6 out of 8 trials correct in a practice trial then
# skip ahead to the real testing trial. If the subject fails to get
# 6 out of 8 in 3 practice blocks then end the task.
PRACTICE_MAX_STREAK = 6

# Max number of practice blocks to try before aborting task
PRACTICE_MAX_BLOCKS = 3

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

# how many has the patient gotten correct in practice block?
numCorrectInPractice = 0

numPracticeBlocks = 1

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

  next: ->
    @currentTrialNum += 1
    if @currentTrialNum is @trialListLength
      @currentTrialNum = 0
      @currentRepNum += 1
    if @currentRepNum >= @numReps
      @finished = true

    if @finished
      @currentTrial = false
      false
    else
      index = @sequenceIndices[@currentRepNum][@currentTrialNum]
      @currentTrial = @trialList[index]
    
  pp: ->
    pp(JSON.stringify(@sequenceIndices))

PRACTICE_BLOCK = new TrialHandler(1)
TESTING_BLOCK = new TrialHandler(2)

#PRACTICE_BLOCK.pp()
#TESTING_BLOCK.pp()

# are we in practice mode?
inPracticeMode = ->
  (numPracticeBlocks <= PRACTICE_MAX_BLOCKS \
    and numCorrectInPractice < PRACTICE_MAX_STREAK)

showArrow = (arrows, upDown) ->
  $arrow = $('#'+arrows+'_'+upDown)
  $arrow.show()

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

showCurrentTrial = ->
  clearStimuli()
  $('#fixation').show()

  TabCAT.UI.wait(_.random(FIXATION_PERIOD_MIN, FIXATION_PERIOD_MAX)).then(->
    $arrow = $('#' + currentTrial.arrows + '_' + currentTrial.upDown)
    $arrow.show()
    #TabCAT.UI.wait(STIMULI_DISPLAY_DURATION).then(->
      #alert 'no response after 4 seconds'
      #$arrow.hide()
    #)
  )

hideFeedback = ->
  $feedback = $('#feedback')
  $feedback.hide()

showFeedback = (correct) ->
  if correct
    msg = $.t('feedback_correct_html')
  else
    msg = $.t('feedback_incorrect_html')
  $feedback = $('#feedback').text(msg)
  $feedback.show()

next = ->
  if inPracticeMode()
    currentTrial = PRACTICE_BLOCK.next()
    if !currentTrial # reached end of block
      if numPracticeBlocks is PRACTICE_MAX_BLOCKS
        alert 'you failed all 3 practice blocks'
        return
      else
        $('#translations').html($.t('additional_practice_html'))
        alert 'beginning new practice block'
        PRACTICE_BLOCK.reset() # start a new practice block
        numCorrectInPractice = 0
        numPracticeBlocks += 1
        currentTrial = PRACTICE_BLOCK.next()
  else
    currentTrial = TESTING_BLOCK.next()
    if !currentTrial
      alert 'you reached the end of testing block'
      return
      
  showCurrentTrial()

handleResponseTouchStart = (event) ->
  event.preventDefault()
  event.stopPropagation()
  
  clearStimuli()
  response = event.target.value.toLowerCase()
  correct = currentTrial.corrAns is response

  if inPracticeMode()
    showFeedback(correct)
    TabCAT.UI.wait(PRACTICE_FEEDBACK_DISPLAY_DURATION).then(->
      hideFeedback()
      TabCAT.UI.wait(PRACTICE_PRE_TRIAL_DELAY).then(->
        next()
      )
    )
    if correct
      numCorrectInPractice += 1
      if not inPracticeMode() # i.e. we just left practice mode
        alert 'just left practice mode'
  else
    TabCAT.UI.wait(PRE_TRIAL_DELAY).then(->
      next()
    )

  pp(JSON.stringify(numPracticeBlocks) + ' | ' + \
    JSON.stringify(numCorrectInPractice) + ' | ' + PRACTICE_BLOCK.getSequence())


handleBeginClick = (event) ->
  hideBeginButton()
  showResponseButtons()
  next()

# INSTRUCTIONS
showStartScreen = ->
  $intro = $('#translations')
  $intro.html($.t('practice_html'))
  
  $beginButton = $('#beginButton')
  $beginButton.on('click', handleBeginClick)
  
  $responseButtons = $('#leftResponseButton, #rightResponseButton')
  $responseButtons.on('mousedown touchstart', handleResponseTouchStart)
  
  $intro.show()
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

