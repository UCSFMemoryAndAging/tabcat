
# The flanker block runs a set number of trials
# (randomly ordered) and each trial has the following structure:
# 1) Pre Trial Delay: 0.2 seconds in the real testing and 0.4 seconds
#    in the practice blocks
# 2) Fixation Period: displays fixation stimuli (i.e. the "+" image")
#    for at least 1 second and no more than 3 seconds (random)
# 3) Stimuli Display: displays the trial stimuli (i.e. the arrows)
#    for 4 seconds or until the subject provides a keyboard response
# 4) Feedback Display: in practice trials, displays feedback to the subject
#    about their response for 2 seconds

# translations current not used, need to update
#
# since so much content is in flanker.html recommend using the
# data-i18n attribute and updating with $element.i18n()
translations =
  en:
    translation:
      begin_html:
        'Begin'
      practice_html:
        1: 'You will be shown a series of arrows on the screen,</br>' +
           'pointing to the left or to the right. For example:'
        2: 'or'
        3: 'Press the RIGHT button if the CENTER arrow ' +
           'points to the right.<br/>' +
           'Press the LEFT button if the CENTER arrow ' +
           'points to the left.'
        4: 'Try to respond as quickly and accurately as you can.'
        5: 'Try to keep your attention focused on the ' +
           'cross ("+") at the center of the screen.'
        6: 'First we\'ll do a practice trial.'
        7: 'Tap the "Begin" button when you are ready to begin.'
      additional_practice_html:
        1: 'You have completed the practice trial. ' +
           'Let\'s do another practice trial.'
        2: 'You will be shown a series of arrows on the screen, <br/>' +
           'pointing to the left or to the right. For example:'
        3: 'or'
        4: 'Press the RIGHT button if the CENTER arrow ' +
           'points to the right.</br>' +
           'Press the LEFT button if the CENTER arrow ' +
           'points to the left.'
        5: 'Try to respond as quickly and accurately as you can.'
        6: 'Try to keep your attention focused on the ' +
           'cross ("+") at the center of the screen.'
        7: 'Tap the "Begin" button when you are ready to begin.'
      testing_html:
        1: 'Now we\'ll move on to the task, the instructions are ' +
           'the same except you will no longer receive feedback ' +
           'after your responses.</br>'
        2: 'Press the LEFT button if the CENTER arrow ' +
           'points to the left.'
        3: 'Press the RIGHT button if the CENTER arrow ' +
           'points to the right.</br>'
        4: 'Remember to keep your focus on the center cross ("+") and try to ' +
           'respond as quickly as possible without making mistakes.'
        5: 'Tap the "Begin" button when you are ready to begin.'
      feedback_correct:
        'Correct!'
      feedback_incorrect:
        'Incorrect.'
      feedback_no_response:
        'No response detected.'
  es:
    translation:
      begin_html:
        'Begin'
      practice_html:
        1: 'La pantalla mostrará una serie de flechas que señalan ' +
           'hacia la izquierda o hacia la derecha. Por ejemplo:'
        2: 'O bien'
        3: 'Presione el botón IZQUIERDO si la flecha CENTRAL ' +
           'señala hacia la izquierda.</br>' +
           'Presione el botón DERECHO si la flecha CENTRAL ' +
           'señala hacia la derecha.<br/>'
        4: 'Intente responder tan rápido y preciso como pueda.'
        5: 'Intente mantener su atención concentrada en la cruz (“+”) ' +
           'en el centro de la pantalla.'
        6: 'Primero haremos una prueba de práctica.'
        7: 'Presione la BARRA ESPACIADORA para comenzar.'
      additional_practice_html:
        1: 'Ha completado la prueba de práctica. ' +
            'Hagamos otra prueba de práctica.'
        2: 'La pantalla mostrará una serie de flechas que señalan hacia ' +
           'la izquierda o hacia la derecha. Por ejemplo:'
        3: 'O bien'
        4: 'Presione el botón DERECHO si la flecha CENTRAL ' +
           'señala hacia la derecha.</br>' +
           'Presione el botón IZQUIERDO si la flecha CENTRAL ' +
           'señala hacia la izquierda.'
        5: 'Intente responder tan rápido y preciso como pueda.'
        6: 'Intente mantener su atención concentrada en la cruz (“+”) ' +
           'en el centro de la pantalla.'
        7: 'Presione la BARRA ESPACIADORA para comenzar.'
      testing_html:
        1: 'Ahora pasaremos a la tarea. Las instrucciones son las mismas, ' +
           'sólo que ya no recibirá comentarios o sugerencias ' +
           'después de sus respuestas.'
        2: 'Presione el botón IZQUIERDO si la flecha CENTRAL ' +
           'señala hacia la izquierda.'
        3: 'Presione el botón DERECHO si la flecha CENTRAL ' +
           'señala hacia la derecha.'
        4: 'Recuerde mantener el foco en la cruz central (“+”) e intente ' +
           'responder lo más rápido posible sin cometer errores.'
        5: 'Presione la BARRA ESPACIADORA cuando esté listo para empezar.'
      feedback_correct:
        'Correcto!'
      feedback_incorrect:
        'Incorrecto.'
      feedback_no_response:
        'No responda.'
  zh:
    translation:
      begin_html:
        '開始'
      practice_html:
        1: '您將看到一系列指向左邊或右邊的箭頭。列如：'
        2: '或'
        3: '如果中間的箭頭指向右邊，請按右箭頭鍵。</br>' +
           '如果中間的箭頭指向左邊，請按左箭頭鍵。'
        4: '請您儘快和準確地完成這項目。'
        5: '儘量把您的注意力保持集中在屏幕中心的十字架 “＋”。'
        6: '首先，我們會試一次。'
        7: '請按空格鍵開始。'
      additional_practice_html:
        1: '您以經完成練習測試。我們再練習一下。'
        2: '您將看到一系列指向左邊或右邊的箭頭。列如：'
        3: '或'
        4: '如果中間的箭頭指向右邊，請按右箭頭鍵。</br>' +
           '如果中間的箭頭指向左邊，請按左箭頭鍵。'
        5: '請您儘快和準確地完成這項目。'
        6: '儘量把您的注意力保持集中在屏幕中心的十字架 “＋”。'
        7: '請按空格鍵開始。'
      testing_html:
        1: '現在我們開始測試。說明相同，但是您不會再收到電腦的答覆。'
        2: '如果中間的箭頭指向右邊，請按右箭頭鍵。'
        3: '如果中間的箭頭指向左邊，請按左箭頭鍵。'
        4: '請您記住儘量把您的注意力保持集中在屏幕中心的十字架 “＋”，' +
           '也請您儘快和準確地完成這項目。'
        5: '當您準備開始時，請按空格鍵。'
      feedback_correct:
        '正確!'
      feedback_incorrect:
        '錯誤。'
      feedback_no_response:
        '沒有收到任何答覆。'


# used for code testing purposes only
TEST_TRIALS = [
  {'arrows':'lllll', 'upDown':'up'  },
  {'arrows':'lllll', 'upDown':'down'},
  {'arrows':'rrrrr', 'upDown':'up'  },
]

# default trials used for actual testing
DEFAULT_TRIALS = [
  {'arrows':'lllll', 'upDown':'up'  },
  {'arrows':'lllll', 'upDown':'down'},
  {'arrows':'rrrrr', 'upDown':'up'  },
  {'arrows':'rrrrr', 'upDown':'down'},
  {'arrows':'llrll', 'upDown':'up'  },
  {'arrows':'llrll', 'upDown':'down'},
  {'arrows':'rrlrr', 'upDown':'up'  },
  {'arrows':'rrlrr', 'upDown':'down'},
]

# after practice and prior to testing, these throwaway trials are given
# but not included in scoring. the idea is to give additional practice trials
# to get user ready for additional complexity of real testing
THROWAWAY_TRIALS = [
  {'arrows':'llrll', 'upDown':'up'  },
  {'arrows':'lllll', 'upDown':'down'},
]

# For each trial, the correct response is the middle arrow,
# or arrow at index 2 (i.e. for 'llrll', correct answer is 'r')
CORRECT_ARROW_INDEX = 2

# pre trial delay of 0.4 seconds in practice blocks
# (time between response and next fixation)
PRACTICE_PRE_TRIAL_DELAY = 400

# In practice trials, feedback is displayed to subject
# about their responses for 2 seconds
PRACTICE_FEEDBACK_DISPLAY_DURATION = 2000

# If the subject gets 6 out of 8 trials correct in a practice trial then
# skip ahead to the real testing trial. If the subject fails to get
# 6 out of 8 in 3 practice blocks then end the task.
PRACTICE_MIN_CORRECT = 6

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

# how long it takes to fade in a screen
FADE_DURATION = 200

# return a practice block
createPracticeBlock = ->
  Examiner.generateTrials(DEFAULT_TRIALS, 1)
  #Examiner.generateTrials(TEST_TRIALS, 1, 'sequential')

# return throwaway block
createThrowawayBlock = ->
  Examiner.generateTrials(THROWAWAY_TRIALS, 1)
  #Examiner.generateTrials(TEST_TRIALS, 1, 'sequential')

# return a real testing block
createTestingBlock = ->
  Examiner.generateTrials(DEFAULT_TRIALS, 6)
  #Examiner.generateTrials(TEST_TRIALS, 2, 'sequential')

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

# go into throwaway mode only after practice and before real testing
inThrowawayMode = false

# current trial block
# start off with a practice block
trialBlock = createPracticeBlock()

# current trial in current trial block
trialIndex = -1

# current fixation duration for current trial
fixationDuration = null

showFixation = ->
  $('#fixation').show()

hideFixation = ->
  $('#fixation').hide()

showArrow = (arrows, upDown) ->
  $('#' + arrows + '_' + upDown).show()

hideArrow = (arrows, upDown) ->
  $('#' + arrows + '_' + upDown).hide()

clearStimuli = ->
  $stimuli = $('#stimuli')
  $stimuli.children().hide()

showFeedback = (translation) ->
  clearStimuli()
  $translation = $.t(translation)

  $html = switch translation
    when 'feedback_correct' \
      then '<span class="correct">' + $translation + '</span>'
    when 'feedback_incorrect', 'feedback_no_response' \
      then '<span class="incorrect">' + $translation + '</span>'
    else translation

  $feedback = $('#feedback')
  $feedback.html($html)
  $feedback.show()

hideFeedback = ->
  $('#feedback').hide()

# is user response correct
isCorrect = (arrows, response) ->
  arrows.charAt(CORRECT_ARROW_INDEX) is response

# can assume arrows are congruent if the middle
# two characters are the same
isCongruent = (arrows) ->
  return arrows.charAt(CORRECT_ARROW_INDEX) is \
    arrows.charAt(CORRECT_ARROW_INDEX+1)

# heart of the task
showTrial = (trial) ->
  resetSideButtons()

  deferred = new $.Deferred()

  # resolved when user responds
  deferred.done((event, responseTime) ->
    clearStimuli()

    response = event.delegateTarget.value
    correct = isCorrect(trial.arrows, response)

    # record meaning of user response event
    interpretation =
      response: response
      responseTime: responseTime
      correct: correct

    TabCAT.Task.logEvent(getTaskState(), event, interpretation)

    if inPracticeMode
      if correct
        numCorrectInPractice += 1
        showFeedback 'feedback_correct'
      else
        showFeedback 'feedback_incorrect'

      TabCAT.UI.wait(PRACTICE_FEEDBACK_DISPLAY_DURATION).then(->
        hideFeedback()
        TabCAT.UI.wait(PRACTICE_PRE_TRIAL_DELAY).then(->
          next()
        )
      )
    else
      TabCAT.UI.wait(PRE_TRIAL_DELAY).then(->
        next()
      )
  )

  # fails when user does not respond (i.e. trial times out)
  deferred.fail(->
    hideArrow(trial.arrows, trial.upDown)

    # record meaning of the event
    interpretation =
      response: null
      responseTime: 0
      correct: false

    TabCAT.Task.logEvent(getTaskState(), "timeout", interpretation)

    if inPracticeMode
      showFeedback 'feedback_no_response'
      TabCAT.UI.wait(PRACTICE_FEEDBACK_DISPLAY_DURATION).then(->
        hideFeedback()
        next()
      )
    else
      next()
  )

  # start showing the trial
  fixationDuration = _.random(FIXATION_PERIOD_MIN, FIXATION_PERIOD_MAX)
  showFixation()

  TabCAT.UI.wait(fixationDuration).then(->
    trialStartTime = $.now()
    hideFixation()
    resetSideButtons()
    showArrow(trial.arrows, trial.upDown)

    responseStatus = {}

    # if user responds, then resolve
    $('#leftButton, #rightButton') \
    .one('mousedown touchstart', (event) ->
      # don't do this more than once per trial
      # can't use stopPropagation() because it messes with
      # trackWhenPressed()
      if reponseStatus?.responded
        return
      responseStatus.responded = true

      responseTime = $.now() - trialStartTime
      deferred.resolve(event, responseTime)
    )

    # if trial times out, then reject
    TabCAT.UI.wait(STIMULI_DISPLAY_DURATION).then(->
      deferred.reject()
    )

  )

# primary task handler that controls entire flow of task
next = ->
  if trialIndex < trialBlock.length-1 # more trials in block
    trialIndex += 1
    showTrial(trialBlock[trialIndex])
  else # end of block
    if inPracticeMode
      # passed practice, or failed 3 practices, so go to throwaway mode
      if practicePassed() or numPracticeBlocks is PRACTICE_MAX_BLOCKS
        inPracticeMode = false
        inThrowawayMode = true
        trialBlock = createThrowawayBlock()
        trialIndex = -1
        showInstructions($('#testingInstructions'))
      else # start new practice block
        trialBlock = createPracticeBlock()
        trialIndex = -1
        numCorrectInPractice = 0
        numPracticeBlocks += 1
        showInstructions($('#additionalPracticeInstructions'))
    else if inThrowawayMode # after throwaway block, go to real testing
      inThrowawayMode = false
      trialBlock = createTestingBlock()
      trialIndex = -1
      next()
    else
      TabCAT.Task.finish()

# summary of current stimulus
getStimuli = ->
  trial = trialBlock[trialIndex]

  if trial?
    stimuli =
      arrows: trial.arrows
      upDown: trial.upDown
      congruent: isCongruent(trial.arrows)
      fixationDuration: fixationDuration

    return stimuli
  else
    return null

# summary of the current state of the task
getTaskState = ->
  state =
    trialNum: trialIndex
    stimuli: getStimuli()

  if inPracticeMode
    state.practiceMode = true
    state.trialBlock = "practiceBlock" + numPracticeBlocks
  else if inThrowawayMode
    state.trialBlock = "throwawayBlock"
  else
    state.trialBlock = "testingBlock"

  if($('#instructions').is(':visible'))
    state.instructions = true

  return state

# log stray taps
handleStrayTouchStart = (event) ->
  event.preventDefault()
  TabCAT.Task.logEvent(getTaskState(), event)

# load initial screen
showStartScreen = ->
  showInstructions 'practice_html'
  $('#beginButton').html($.t('begin_html'))
  showBeginButton()

# load the stimuli imgs
initStimuli = ->
  # create the arrow imgs
  $imgs = _.map(DEFAULT_TRIALS, (trial) ->
    '<img id="' + trial.arrows + '_' + \
      (if trial.upDown is 'up' then 'up' else 'down') + \
      '" src="img/flanker/' + trial.arrows + '.svg" ' + \
      'style="display:none" ' + \
      'class="arrow ' + \
      (if trial.upDown is 'up' then 'aboveFixation"' else 'belowFixation"') + \
      '>')

  # create fixation img
  $imgs = $imgs.join('') + '<img id="fixation" ' + \
    'src="img/flanker/fixation.svg" ' + \
    'class="fixation" ' +\
    'style="display:none">'

  $('#stimuli').append($imgs)

MAX_TIME_BETWEEN_TAPS = 250
MAX_TIME_BETWEEN_CLICKS = 1000


onBothSideButtons = (callback) ->
  # map from button ID to when it was last tapped
  buttonLastTapped = {}

  # TODO: add TabCAT event logging

  $buttons = $('.sideButton')

  for button in $buttons
    $button = $(button)

    do ($button) ->
      $button.on('touchstart mousedown', (event) ->
        maxTime = MAX_TIME_BETWEEN_TAPS
        if event.type is 'mousedown'
          maxTime = MAX_TIME_BETWEEN_CLICKS

        buttonId = $button.attr('id')
        now = $.now()
        for own otherButtonId, time of buttonLastTapped
          if otherButtonId != buttonId and time >= now - maxTime
            resetSideButtons()
            callback()
            return

        buttonLastTapped[buttonId] = now
      )


# add/remove the "pressed" class to a button to indicate when it's pressed
# this isn't full emulation (if you press a button, slide off it, and slide
# back on, it won't count as pressed), but that's fine since most events in
# TabCAT fire on touchstart/mousedown
trackWhenPressed = ($button, pressedClass) ->
  pressedClass ?= 'pressed'

  $button.on('mousedown touchstart', ->
    $button.addClass('pressed'))
  $button.on('mouseup mouseleave touchend touchcancel', ->
    $button.removeClass('pressed'))


resetSideButtons = ->
  $buttons = $('.sideButton')

  for button in $buttons
    $button = $(button)
    $button.off()
    trackWhenPressed($button)


# show the intial page
showSeatingInstructions = ->
  $seatingInstructions = $('#seatingInstructions')
  resetSideButtons()
  onBothSideButtons(->
    $seatingInstructions.hide()
    showInstructions($('#practiceInstructions'))
  )

  # don't fade in because this is the first thing we show
  $seatingInstructions.show()


# show the full instructions, for before practice
showInstructions = ($instructionsDiv) ->
  resetSideButtons()
  onBothSideButtons(->
    $instructionsDiv.hide()
    next()
  )

  $instructionsDiv.fadeIn(duration: FADE_DURATION)


# INITIALIZATION
@initTask = ->
  TabCAT.Task.start(
    i18n:
      resStore: translations
    trackViewport: true
  )

  TabCAT.UI.turnOffBounce()
  TabCAT.UI.enableFastClick()

  $(->
    $task = $('#task')
    $rectangle = $('#rectangle')
    $square = $('#square')

    $task.on('mousedown touchstart', handleStrayTouchStart)
    TabCAT.UI.fixAspectRatio($rectangle, ASPECT_RATIO)
    TabCAT.UI.linkEmToPercentOfHeight($rectangle)

    # for border-width. have to link to $rectangle because
    # not visible yet
    for $button in $('.sideButton')
      TabCAT.UI.linkEmToPercentOfHeight($button, $rectangle)

    # initialize #stimuli
    initStimuli()

    # start
    showSeatingInstructions()

    $rectangle.fadeIn(duration: FADE_DURATION)
    TabCAT.UI.linkEmToPercentOfHeight($square)
  )
