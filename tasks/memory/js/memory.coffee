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


# empty translations block for now
translations =
  en:
    translation:
      '...'
  es:
    translation:
      '...'

MemoryTask = class
  CHOICES = {
    ANIMAL: {
      DOLPHIN: 'dolphin',
      WOLF: 'wolf',
      TURTLE: 'turtle',
      SHARK: 'shark',
      COW: 'cow',
      BEAR: 'bear',
      FROG: 'frog',
      SHEEP: 'sheep',
      RABBIT: 'rabbit',
      PIG: 'pig',
      WHALE: 'whale',
      GOAT: 'goat',
      MONKEY: 'monkey',
      SNAKE: 'snake',
      FOX: 'fox',
      MOUSE: 'mouse',
      TIGER: 'tiger'
    },
    FOOD: {
      APPLE: 'apple',
      POTATO: 'potato',
      GRAPES: 'grapes',
      MELON: 'melon',
      COCONUT: 'coconut',
      CHERRY: 'cherry',
      LETTUCE: 'lettuce',
      PEAS: 'peas',
      CARROT: 'carrot',
      TOMATO: 'tomato',
      MUSHROOM: 'mushroom',
      LEMON: 'lemon',
      PLUM: 'plum',
      BANANA: 'banana',
      MANGO: 'mango',
      PEPPER: 'pepper',
      SQUASH: 'squash'
    }
  }

  PEOPLE = {
    MAN_EXAMPLE:
      IMAGE: 'man-example.jpg'
    MAN_1:
      IMAGE: 'man1.jpg'
    MAN_2:
      IMAGE: 'man2.jpg'
    MAN_3:
      IMAGE: 'man3.jpg'
    MAN_4:
      IMAGE: 'man4.jpg'
    MAN_5:
      IMAGE: 'man5.jpg'
    MAN_6:
      IMAGE: 'man6.jpg'
    MAN_7:
      IMAGE: 'man7.jpg'
    MAN_8:
      IMAGE: 'man8.jpg'
    WOMAN_EXAMPLE:
      IMAGE: 'woman-example.jpg'
    WOMAN_1:
      IMAGE: 'woman1.jpg'
    WOMAN_2:
      IMAGE: 'woman2.jpg'
    WOMAN_3:
      IMAGE: 'woman3.jpg'
    WOMAN_4:
      IMAGE: 'woman4.jpg'
    WOMAN_5:
      IMAGE: 'woman5.jpg'
    WOMAN_6:
      IMAGE: 'woman6.jpg'
    WOMAN_7:
      IMAGE: 'woman7.jpg'
    WOMAN_8:
      IMAGE: 'woman8.jpg'
  }

  #assigning people and food/animal combinations to different forms
  FORMS = {
    EXAMPLE: [
      {
        FOOD: CHOICES.FOOD.POTATO,
        PERSON: PEOPLE.MAN_EXAMPLE
      },
      {
        ANIMAL: CHOICES.ANIMAL.DOLPHIN,
        PERSON: PEOPLE.WOMAN_EXAMPLE
      }
    ],
    FORM_ONE: [
      {
        PERSON: PEOPLE.MAN_5
        STIMULI:
          ANIMAL:
            label: 'animal',
            item: CHOICES.ANIMAL.TURTLE
          FOOD:
            label: 'food',
            item: CHOICES.FOOD.POTATO
      }
#      {
#        FOOD: CHOICES.FOOD.MELON,
#        ANIMAL: CHOICES.ANIMAL.COW,
#        PERSON: PEOPLE.MAN_6
#      },
#      {
#        FOOD: CHOICES.FOOD.CARROTS,
#        ANIMAL: CHOICES.ANIMAL.WOLF,
#        PERSON: PEOPLE.WOMAN_5
#      },
#      {
#        FOOD: CHOICES.FOOD.CARROTS,
#        ANIMAL: CHOICES.ANIMAL.WOLF,
#        PERSON: PEOPLE.WOMAN_6
#      }
    ]
  }

#    MAN1: { #glasses and red shirt
#      FOOD: CHOICES.FOOD.APPLE,
#      IMAGE: 'man1'
#    },
#    MAN2: { #bald with sport coat
#      FOOD: CHOICES.FOOD.POTATO,
#      ANIMAL: CHOICES.ANIMAL.TURTLE,
#      IMAGE: 'man2'
#    },
#    MAN3: { #purple shirt
#      FOOD: CHOICES.FOOD.MELON,
#      ANIMAL: CHOICES.ANIMAL.COW,
#      IMAGE: 'man3'
#    },
#    WOMAN1: { #long dark hair
#      ANIMAL: CHOICES.ANIMAL.DOLPHIN,
#      IMAGE: 'woman1'
#    },
#    WOMAN2: { #hair pullled back with blue eyes
#      FOOD: CHOICES.FOOD.CARROTS,
#      ANIMAL: CHOICES.ANIMAL.WOLF,
#      IMAGE: 'woman2'
#    },
#    WOMAN3: { #glasses and gray hair
#      FOOD: CHOICES.FOOD.GRAPES,
#      ANIMAL: CHOICES.ANIMAL.SHARK,
#      IMAGE: 'woman3'
#    }

  IMMEDIATE_RECALL = {
    EXAMPLE: [
      { type: 'firstExampleRemember', person: PEOPLE.MAN1, remember: 'food' },
      { type: 'exampleRemember', person: PEOPLE.WOMAN1 , remember: 'animal' },
      { type: 'exampleRecall', person: PEOPLE.MAN1, recall: 'food' },
      { type: 'exampleRecall', person: PEOPLE.WOMAN1, recall: 'animal' }
    ],
    TRIALS: {
      EXPOSURE: [
        {type: 'rememberOne', person: PEOPLE.MAN2, remember: 'food'},
        {type: 'rememberOne', person: PEOPLE.WOMAN2, remember: 'animal'},
        {type: 'rememberOne', person: PEOPLE.WOMAN3, remember: 'food'},
        {type: 'rememberOne', person: PEOPLE.MAN2, remember: 'animal'},
        {type: 'rememberOne', person: PEOPLE.MAN3, remember: 'food'},
        {type: 'rememberOne', person: PEOPLE.WOMAN3, remember: 'animal'},
        {type: 'rememberOne', person: PEOPLE.MAN3, remember: 'animal'},
        {type: 'rememberOne', person: PEOPLE.WOMAN2, remember: 'food'}
      ],
      RECALL: [
        {type: 'recallTwo', person: PEOPLE.MAN2},
        {type: 'recallTwo', person: PEOPLE.WOMAN3},
        {type: 'recallTwo', person: PEOPLE.WOMAN2},
        {type: 'recallTwo', person: PEOPLE.MAN3}
      ],
      DELAYED_RECALL: {
        REMEMBER: [
          {type: 'rememberOne', person: PEOPLE.WOMAN2, remember: 'animal'},
          {type: 'rememberOne', person: PEOPLE.MAN2, remember: 'food'},
          {type: 'rememberOne', person: PEOPLE.WOMAN3, remember: 'animal'},
          {type: 'rememberOne', person: PEOPLE.MAN2, remember: 'animal'},
          {type: 'rememberOne', person: PEOPLE.WOMAN2, remember: 'food'},
          {type: 'rememberOne', person: PEOPLE.MAN3, remember: 'animal'},
          {type: 'rememberOne', person: PEOPLE.WOMAN3, remember: 'food'},
          {type: 'rememberOne', person: PEOPLE.MAN3, remember: 'food'}
        ],
        RECALL: [
          {type: 'recallTwo', person: PEOPLE.MAN3},
          {type: 'recallTwo', person: PEOPLE.MAN2},
          {type: 'recallTwo', person: PEOPLE.WOMAN3},
          {type: 'recallTwo', person: PEOPLE.WOMAN2}
        ]
      }
    }
  }
  # main div's aspect ratio (pretend we're on an iPad)
  ASPECT_RATIO = 4/3

  # time values in milliseconds
  TIME_BETWEEN_STIMULI = 3000

  TIME_BETWEEN_RECALL = 10000

  constructor: ->
    #current form - static for now, will add switch later
    #@currentForm = FORM_ORDER.FORM_ONE
    #@currentFormNumber = 1

    #current digit presented on screen
    @currentStimuli = null

    @secondsElapsed = 0

    @isInDebugMode = TabCAT.Task.isInDebugMode()

    @practiceTrialsShown = 0

    #can switch this later
    @currentForm = 'FORM_ONE'

    @sequence = @generateRandomSequences(@currentForm)

  #needs randomzied exposure and recall
  generateRandomSequences: (currentForm) ->
    sequence = []

    for data in FORMS[currentForm]
      do ->
        for stimuli in data.STIMULI
          do ->
            obj =
              action: 'rememberOne',
              person: data.PERSON,
              type: stimuli.label
              item: stimuli.item

        sequence.push obj
        obj = {type: 'rememberOne', person: person, remember: 'animal'}
        sequence.push obj

    sequence = _.shuffle sequence
    console.log sequence




  showStartScreen: ->
    @showNextTrial(@currentForm.EXAMPLE)

    $("#task").one('tap', =>
      @iterateExampleScreens(@currentForm)
    )

  iterateExampleScreens: (form) ->
    @showNextTrial(form.EXAMPLE)

    TabCAT.UI.wait(TIME_BETWEEN_STIMULI).then( =>
      if form.EXAMPLE.length
        @iterateExampleScreens(form)
      else
        @showInstructionsScreen()
    )

  iterateRememberTrials: (form) ->
    @showNextTrial(form.TRIALS.IMMEDIATE_RECALL.REMEMBER)

    TabCAT.UI.wait(TIME_BETWEEN_STIMULI).then( =>
      if form.TRIALS.IMMEDIATE_RECALL.REMEMBER.length
        @iterateRememberTrials(form)
      else
        @beginRecall(form)
    )

  showNextTrial: (slides) ->
    nextSlide = slides.shift()
    # looking to move away from switch, will refactor later.
    # looking for something to automatically call
    # function with the same name as type, but there's some strange
    # behavior regarding scope that I don't yet understand
    switch nextSlide.type
      when "firstExampleRemember" then \
        @firstExampleRemember nextSlide.person, nextSlide.remember
      when "exampleRemember" then \
        @exampleRemember nextSlide.person, nextSlide.remember
      when "exampleRecall" then \
        @exampleRecall nextSlide.person, nextSlide.recall
      when "rememberOne" then \
        @rememberOne nextSlide.person, nextSlide.remember
      when "recallTwo" then \
        @recallTwo nextSlide.person
      else console.log "some other type"

  showInstructionsScreen: ->
    $("#task").unbind()
    $("#exampleScreen").hide()
    $("#trialScreen").hide()
    $("#instructionsScreen").show()

    $("#task").one('tap', =>
      @beginTrials(@currentForm)
    )

  showRememberScreen: ->
    $("#exampleScreen").hide()
    $("#trialScreen").hide()
    $("#instructionsScreen").hide()
    $("#rememberScreen").show()
    #resume after this

  showBlankScreen: ->
    $("#exampleScreen").hide()
    $("#trialScreen").hide()
    $("#instructionsScreen").hide()
    $("#rememberScreen").hide()

  beginTrials: (form) ->
    @showRememberScreen()
    TabCAT.UI.wait(TIME_BETWEEN_STIMULI).then( =>
      $("#rememberScreen").hide()
      @iterateRememberTrials(form)
    )

  beginRecall: (form) ->
    @showBlankScreen()

    $("#task").unbind().on('tap', =>
      $("#rememberScreen").hide()

      if form.TRIALS.IMMEDIATE_RECALL.RECALL.length
        @showNextTrial(form.TRIALS.IMMEDIATE_RECALL.RECALL)
      else
        $("#task").unbind()
        console.log "out of recalls"
    )

  start: ->
    TabCAT.Task.start(
      i18n:
        resStore: translations
      trackViewport: true
    )
    TabCAT.UI.turnOffBounce()

    $task = $('#task')
    $rectangle = $('#rectangle')

    TabCAT.UI.requireLandscapeMode($task)
    $task.on('mousedown touchstart', ( -> ) )

    TabCAT.UI.fixAspectRatio($rectangle, ASPECT_RATIO)
    TabCAT.UI.linkEmToPercentOfHeight($rectangle)

    @showStartScreen()

  firstExampleRemember: (person, remember) ->
    $("#exampleImage img").attr('src', "img/" + person.IMAGE)
    $("#exampleFood").empty().html("<p>" + person.FOOD + "</p>")
    $("#exampleScreen").show()

  exampleRemember: (person, remember) ->
    $("#exampleScreen").hide()
    $("#recallOne").hide()
    $("#recallBoth").hide()

    $("#screenImage img").attr('src', "img/" + person.IMAGE)
    $("#rememberOne").show().empty().html( \
      "<p>" + person[remember.toUpperCase()] + "</p>" )
    $("#trialScreen").show()

  exampleRecall: (person, recall) ->
    $("#exampleScreen").hide()
    $("#rememberOne").hide()
    $("#recallBoth").hide()

    #does nothing for now, may use to validate later
    correctAnswer = person[recall.toUpperCase()]

    $("#screenImage img").attr('src', "img/" + person.IMAGE)
    $("#recallOne").show().find(".recallLabel").empty().html(recall + ":")
    $("#trialScreen").show()

  rememberOne: (person, remember) ->
    $("#recallBoth").hide()
    $("#recallOne").hide()

    $("#screenImage img").attr('src', "img/" + person.IMAGE)
    $("#rememberOne").show().empty().html(
      "<p>" + person[remember.toUpperCase()] + "</p>" )
    $("#trialScreen").show()

  recallTwo: (person) ->
    $("#exampleScreen").hide()
    $("#rememberOne").hide()
    $("#recallOne").hide()
    $("#recallBoth").hide()

    $("#screenImage img").attr('src', "img/" + person.IMAGE)
    $("#recallBoth").show()
    $("#trialScreen").show()


@ImmediateRecallMemoryTask = class extends MemoryTask
  constructor: ->
    super()

#Not implementing for now, just creating the skeleton
@DelayedRecallMemoryTask = class extends MemoryTask
  constructor: ->
    super()