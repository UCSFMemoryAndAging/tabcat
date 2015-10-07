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
      instructions_before_face:
        1: 'You will need to remember people <br> and their favorite things.'
      instructions_favorite_food:
        1: 'For example, remember that her favorite food is an...'
      instructions_favorite_animal:
        1: 'And her favorite animal is a...'
      instructions_remember:
        1: 'Now you will see some more faces. ' +
           'You will see each face twice; once with their favorite ' +
           'food and once with their favorite animal.'
        2: 'Remember both.'
      instructions_ready:
        1: 'Are you ready to begin?'
  es:
    translation:
      '...'

MemoryTask = class
  constructor: ->

    @CHOICES = {
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

    @PEOPLE = {
      MAN_EXAMPLE:
        KEY: 'man-example'
        IMAGE: 'man-example.jpg'
      MAN_1:
        KEY: 'man1'
        IMAGE: 'man1.jpg'
        FOOD: @CHOICES.FOOD.MELON
        ANIMAL: @CHOICES.ANIMAL.RABBIT
      MAN_2:
        KEY: 'man2'
        IMAGE: 'man2.jpg'
        FOOD: @CHOICES.FOOD.POTATO
        ANIMAL: @CHOICES.ANIMAL.FROG
      MAN_3:
        KEY: 'man3'
        IMAGE: 'man3.jpg'
        FOOD: @CHOICES.FOOD.PLUM
        ANIMAL: @CHOICES.ANIMAL.PIG
      MAN_4:
        KEY: 'man4'
        IMAGE: 'man4.jpg'
        FOOD: @CHOICES.FOOD.MUSHROOM
        ANIMAL: @CHOICES.ANIMAL.WHALE
      MAN_5:
        KEY: 'man5'
        IMAGE: 'man5.jpg'
        FOOD: @CHOICES.FOOD.COCONUT
        ANIMAL: @CHOICES.ANIMAL.TURTLE
      MAN_6:
        KEY: 'man6'
        IMAGE: 'man6.jpg'
        FOOD: @CHOICES.FOOD.CHERRY
        ANIMAL: @CHOICES.ANIMAL.WOLF
      MAN_7:
        KEY: 'man7'
        IMAGE: 'man7.jpg'
        FOOD: @CHOICES.FOOD.BANANA
        ANIMAL: @CHOICES.ANIMAL.FOX
      MAN_8:
        KEY: 'man8'
        IMAGE: 'man8.jpg'
        FOOD: @CHOICES.FOOD.SQUASH
        ANIMAL: @CHOICES.ANIMAL.SNAKE
      WOMAN_EXAMPLE:
        KEY: 'woman-example'
        IMAGE: 'woman-example.jpg'
        FOOD: @CHOICES.FOOD.APPLE
        ANIMAL: @CHOICES.ANIMAL.DOLPHIN
      WOMAN_1:
        KEY: 'woman1'
        IMAGE: 'woman1.jpg'
        FOOD: @CHOICES.FOOD.GRAPES
        ANIMAL: @CHOICES.ANIMAL.SHEEP
      WOMAN_2:
        KEY: 'woman2'
        IMAGE: 'woman2.jpg'
        FOOD: @CHOICES.FOOD.CARROT
        ANIMAL: @CHOICES.ANIMAL.BEAR
      WOMAN_3:
        KEY: 'woman3'
        IMAGE: 'woman3.jpg'
        FOOD: @CHOICES.FOOD.TOMATO
        ANIMAL: @CHOICES.ANIMAL.GOAT
      WOMAN_4:
        KEY: 'woman4'
        IMAGE: 'woman4.jpg'
        FOOD: @CHOICES.FOOD.LEMON
        ANIMAL: @CHOICES.ANIMAL.MONKEY
      WOMAN_5:
        KEY: 'woman5'
        IMAGE: 'woman5.jpg'
        FOOD: @CHOICES.FOOD.LETTUCE
        ANIMAL: @CHOICES.ANIMAL.SHARK
      WOMAN_6:
        KEY: 'woman6'
        IMAGE: 'woman6.jpg'
        FOOD: @CHOICES.FOOD.PEAS
        ANIMAL: @CHOICES.ANIMAL.COW
      WOMAN_7:
        KEY: 'woman7'
        IMAGE: 'woman7.jpg'
        FOOD: @CHOICES.FOOD.PEPPER
        ANIMAL: @CHOICES.ANIMAL.TIGER
      WOMAN_8:
        KEY: 'woman8'
        IMAGE: 'woman8.jpg'
        FOOD: @CHOICES.FOOD.MANGO
        ANIMAL: @CHOICES.ANIMAL.MOUSE
    }

    @EXAMPLE_PEOPLE = [
      @PEOPLE.WOMAN_EXAMPLE
    ]

    #assigning people and food/animal combinations to different forms
    @FORMS = {
      FORM_ONE:
        PEOPLE: [
          @PEOPLE.MAN_5,
          @PEOPLE.MAN_6,
          @PEOPLE.WOMAN_5,
          @PEOPLE.WOMAN_6
        ]
        FIRST_EXPOSURE: [
          { person: @PEOPLE.MAN_5, item: 'animal' },
          { person: @PEOPLE.WOMAN_6, item: 'food' },
          { person: @PEOPLE.WOMAN_5, item: 'food' },
          { person: @PEOPLE.MAN_6, item: 'animal' },
          { person: @PEOPLE.WOMAN_5, item: 'animal'},
          { person: @PEOPLE.MAN_5, item: 'food' },
          { person: @PEOPLE.MAN_6, item: 'food' },
          { person: @PEOPLE.WOMAN_6, item: 'animal'}
        ],
        RECALL_ONE: [
          { person: @PEOPLE.WOMAN_5 },
          { person: @PEOPLE.MAN_5 },
          { person: @PEOPLE.WOMAN_6 },
          { person: @PEOPLE.MAN_6 }
        ],
        SECOND_EXPOSURE: [
          { person: @PEOPLE.WOMAN_5, item: 'animal' },
          { person: @PEOPLE.MAN_5, item: 'animal' },
          { person: @PEOPLE.WOMAN_6, item: 'food' },
          { person: @PEOPLE.MAN_6, item: 'food' },
          { person: @PEOPLE.WOMAN_6, item: 'animal' },
          { person: @PEOPLE.WOMAN_5, item: 'food'},
          { person: @PEOPLE.MAN_6, item: 'animal'},
          { person: @PEOPLE.MAN_5, item: 'food'}
        ],
        RECALL_TWO: [
          { person: @PEOPLE.MAN_6 },
          { person: @PEOPLE.MAN_5 },
          { person: @PEOPLE.WOMAN_6 },
          { person: @PEOPLE.WOMAN_5 }
        ],
        DELAYED_RECALL: [
          { person: @PEOPLE.WOMAN_6 },
          { person: @PEOPLE.MAN_5 },
          { person: @PEOPLE.MAN_6 },
          { person: @PEOPLE.WOMAN_5 }
        ]
      FORM_TWO:
        PEOPLE: [
          @PEOPLE.MAN_1,
          @PEOPLE.MAN_2,
          @PEOPLE.WOMAN_1,
          @PEOPLE.WOMAN_2
        ]
        FIRST_EXPOSURE: [
          { person: @PEOPLE.WOMAN_1, item: 'animal'},
          { person: @PEOPLE.WOMAN_2, item: 'food' },
          { person: @PEOPLE.MAN_2, item: 'animal' },
          { person: @PEOPLE.WOMAN_1, item: 'food'},
          { person: @PEOPLE.MAN_1, item: 'animal' },
          { person: @PEOPLE.MAN_2, item: 'food' },
          { person: @PEOPLE.WOMAN_2, item: 'animal' },
          { person: @PEOPLE.MAN_1, item: 'food' }
        ],
        RECALL_ONE: [
          { person: @PEOPLE.WOMAN_1 },
          { person: @PEOPLE.MAN_2 },
          { person: @PEOPLE.WOMAN_2 },
          { person: @PEOPLE.MAN_1 }
        ],
        SECOND_EXPOSURE: [
          { person: @PEOPLE.MAN_2, item: 'animal' },
          { person: @PEOPLE.WOMAN_1, item: 'food' },
          { person: @PEOPLE.MAN_1, item: 'food' },
          { person: @PEOPLE.WOMAN_2, item: 'food' },
          { person: @PEOPLE.WOMAN_1, item: 'animal' },
          { person: @PEOPLE.MAN_1, item: 'animal' },
          { person: @PEOPLE.MAN_2, item: 'food' },
          { person: @PEOPLE.WOMAN_2, item: 'animal' }
        ],
        RECALL_TWO: [
          { person: @PEOPLE.MAN_2 },
          { person: @PEOPLE.WOMAN_1 },
          { person: @PEOPLE.WOMAN_2 },
          { person: @PEOPLE.MAN_1 }
        ],
        DELAYED_RECALL: [
          { person: @PEOPLE.WOMAN_2 },
          { person: @PEOPLE.MAN_1 },
          { person: @PEOPLE.WOMAN_1 },
          { person: @PEOPLE.MAN_2 }
        ]
      FORM_THREE:
        PEOPLE: [
          @PEOPLE.MAN_3,
          @PEOPLE.MAN_4,
          @PEOPLE.WOMAN_3,
          @PEOPLE.WOMAN_4
        ]
        FIRST_EXPOSURE: [
          { person: @PEOPLE.MAN_3, item: 'animal' },
          { person: @PEOPLE.WOMAN_3, item: 'food' },
          { person: @PEOPLE.MAN_4, item: 'animal' },
          { person: @PEOPLE.WOMAN_4, item: 'animal' },
          { person: @PEOPLE.WOMAN_3, item: 'animal' },
          { person: @PEOPLE.WOMAN_4, item: 'food' },
          { person: @PEOPLE.MAN_3, item: 'food' },
          { person: @PEOPLE.MAN_4, item: 'food'}
        ],
        RECALL_ONE: [
          { person: @PEOPLE.WOMAN_3 },
          { person: @PEOPLE.MAN_3 },
          { person: @PEOPLE.MAN_4 },
          { person: @PEOPLE.WOMAN_4 }
        ],
        SECOND_EXPOSURE: [
          { person: @PEOPLE.MAN_4, item: 'animal' },
          { person: @PEOPLE.WOMAN_4, item: 'animal' },
          { person: @PEOPLE.WOMAN_3, item: 'animal' },
          { person: @PEOPLE.MAN_4, item: 'food' },
          { person: @PEOPLE.MAN_3, item: 'food' },
          { person: @PEOPLE.WOMAN_3, item: 'food' },
          { person: @PEOPLE.WOMAN_4, item: 'food' },
          { person: @PEOPLE.MAN_3, item: 'animal'}
        ],
        RECALL_TWO: [
          { person: @PEOPLE.MAN_3 },
          { person: @PEOPLE.WOMAN_3 },
          { person: @PEOPLE.MAN_4 },
          { person: @PEOPLE.WOMAN_4 }
        ],
        DELAYED_RECALL: [
          { person: @PEOPLE.WOMAN_4 },
          { person: @PEOPLE.MAN_4 },
          { person: @PEOPLE.WOMAN_3 },
          { person: @PEOPLE.MAN_3 }
        ]
      FORM_FOUR:
        PEOPLE: [
          @PEOPLE.MAN_7,
          @PEOPLE.MAN_8,
          @PEOPLE.WOMAN_7,
          @PEOPLE.WOMAN_8
        ]
        FIRST_EXPOSURE: [
          { person: @PEOPLE.WOMAN_7, item: 'food' },
          { person: @PEOPLE.MAN_8, item: 'animal' },
          { person: @PEOPLE.WOMAN_8, item: 'food' },
          { person: @PEOPLE.MAN_7, item: 'animal' },
          { person: @PEOPLE.WOMAN_7, item: 'animal' },
          { person: @PEOPLE.MAN_7, item: 'food' },
          { person: @PEOPLE.WOMAN_8, item: 'animal' },
          { person: @PEOPLE.MAN_8, item: 'food'}
        ],
        RECALL_ONE: [
          { person: @PEOPLE.WOMAN_7 },
          { person: @PEOPLE.MAN_8 },
          { person: @PEOPLE.WOMAN_8 },
          { person: @PEOPLE.MAN_7 }
        ],
        SECOND_EXPOSURE: [
          { person: @PEOPLE.WOMAN_8, item: 'animal' },
          { person: @PEOPLE.MAN_7, item: 'animal' },
          { person: @PEOPLE.WOMAN_7, item: 'animal' },
          { person: @PEOPLE.WOMAN_8, item: 'food' },
          { person: @PEOPLE.MAN_8, item: 'food' },
          { person: @PEOPLE.WOMAN_7, item: 'food' },
          { person: @PEOPLE.MAN_8, item: 'animal' },
          { person: @PEOPLE.MAN_7, item: 'food'}
        ]
        RECALL_TWO: [
          { person: @PEOPLE.WOMAN_8 },
          { person: @PEOPLE.MAN_8 },
          { person: @PEOPLE.MAN_7 },
          { person: @PEOPLE.WOMAN_7 }
        ],
        DELAYED_RECALL: [
          { person: @PEOPLE.MAN_7 },
          { person: @PEOPLE.WOMAN_7 },
          { person: @PEOPLE.MAN_8 },
          { person: @PEOPLE.WOMAN_8 }
        ]
    }

    [@currentForm, @currentFormNumber, @currentFormLabel] = @getCurrentForm()

    @scores = {}

    # main div's aspect ratio (pretend we're on an iPad)
    @ASPECT_RATIO = 4/3

    # time values in milliseconds
    @TIME_BETWEEN_STIMULI = 30

    @FADE_IN_TIME = 10

    @FADE_OUT_TIME = 10

  buildInitialState: (recalls) ->
    state = {}
    for recall in recalls
      do =>
        data = []
        _.each(@currentForm[recall], (person) ->
          data[person.person.KEY] = person
        )
        state[recall] = data
    return state

  #returns a tuple
  getCurrentForm: ->
    form = TabCAT.UI.getQueryString 'form'
    #there's likely a much more efficient way to do this
    #note that forms 3 and 4 do not currently exist yet
    switch form
      when "one" then return [@FORMS.FORM_ONE, 1, 'A']
      when "two" then return [@FORMS.FORM_TWO, 2, 'B']
      when "three" then return [@FORMS.FORM_THREE, 3, 'C']
      when "four" then return [@FORMS.FORM_FOUR, 4, 'D']
    #if no form found, just return default form
    return [@FORMS.FORM_ONE, 1, 'A']

  buildScoringSheetsData: (currentForm) ->
    #we can derive the people and the list of total food
    #directly from each of the forms
    people = currentForm.RECALL_ONE
    food = []
    animals = []
    for person in people
      do ( ->
        food.push(person.person.FOOD)
        animals.push(person.person.ANIMAL)
      )

    food = food.concat(["other", "DK"])
    animals = animals.concat(["other", "DK"])

    sheets =
      people: people
      food: food
      animals: animals

    return sheets

  generateExposureStimuli: (exposureData) ->
    stimuli = []

    for data in exposureData
      do ( ->
        obj =
          action: 'rememberOne',
          person: data.person,
          item: data.item

        stimuli.push obj
      )

    return stimuli

  generateRecalls: (recallData) ->
    recalls = new Array()
    for data in recallData
      do ( ->
        obj = { action: 'recallBoth', person: data.person }
        recalls.push obj
      )
    return recalls

  showNextTrial: (slide) ->
    # looking to move away from switch, will refactor later.
    # looking for something to automatically call
    # function with the same name as type, but there's some strange
    # behavior regarding scope that I don't yet understand
    switch slide.action
      when "rememberOne" then \
        @rememberOne slide.person, slide.item
      when "recallBoth" then \
        @recallBoth slide.person

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

    TabCAT.UI.fixAspectRatio($rectangle, @ASPECT_RATIO)
    TabCAT.UI.linkEmToPercentOfHeight($rectangle)

    @showStartScreen()

  preloadEncounterImageData: (parentElement, sourcePeople) ->
    for person in sourcePeople
      do =>
        $image = @buildFaceElement(person, 'encounterFace')
        parentElement.append($image)

  preloadScoringImageData: (recalls) ->
    for containerName, recall of recalls
      do =>
        personContainerClasses = @getPersonContainerClasses()
        for person in recall
          do =>
            $image = @buildFaceElement(person.person, 'scoringFace')
            personContainerClass = personContainerClasses.shift()
            $container = $("#" + containerName + " ." + personContainerClass)
            $container.data('person', person.person.KEY)
            $container.find('.scoringImage').append($image)
            $food = @buildFoodOptions(person.person.FOOD)
            $animal = @buildAnimalOptions(person.person.ANIMAL)
            $container.find('.scoringFood').append($food)
            $container.find('.scoringAnimal').append($animal)

  getPersonContainerClasses: ->
    ['personOne', 'personTwo', 'personThree', 'personFour']

  buildFaceElement: (person, className) ->
    $image = $('<img>')
      .attr( 'src', "img/" + person.IMAGE )
      .attr('data-person', person.KEY)
    if className
      $image.addClass(className)
    return $image

  buildFoodOptions: (correctFood) ->
    data = @buildScoringSheetsData(@currentForm)

    $food = $('<ul></ul>').addClass('foodSelection')
    for food in data.food
      do =>
        $li = $('<li></li>')
        if food == correctFood
          $li.addClass('correctFood')
        $li.html(food)
        $li.data('food', food)
        $food.append($li)

    return $food

  buildAnimalOptions: (correctAnimal) ->
    data = @buildScoringSheetsData(@currentForm)

    $animal = $('<ul></ul>').addClass('animalSelection')
    for animal in data.animals
      do =>
        $li = $('<li></li>')
        if animal == correctAnimal
          $li.addClass('correctAnimal')
        $li.html(animal)
        $li.data('animal', animal)
        $animal.append($li)

    return $animal

  showPerson: (person, fadeIn = false) ->
    $(".encounterFace").hide()
    $image = $(".encounterFace[data-person='" + person.KEY + "']")
    if fadeIn
      $image.fadeIn(@FADE_IN_TIME)
    else
      $image.show()

  rememberOne: (person, item) ->
    stimuli = person[item.toUpperCase()]
    $("#recallBoth").hide()
    $("#recallOne").hide()

    @showPerson(person, true)
    $("#rememberOne").empty().html(
      "<p>" + stimuli + "</p>" ).fadeIn(@FADE_IN_TIME)
    $("#trialScreen").show()

  recallBoth: (person) ->
    $("#exampleScreen").hide()
    $("#rememberOne").hide()

    @showPerson(person)
    $("#recallBoth").show()
    $("#recallNextButton").show()
    $("#trialScreen").show()

  scoringTouchHandler: (event, type, scoringScreen) ->
    #default to animalSelection
    className = '.foodSelection'
    parentClass = '.scoringFood'
    if type == 'animal'
      className = '.animalSelection'
      parentClass = '.scoringAnimal'

    $target = $(event.target)
    $scoringElement = $target.parent('.selectionContainer').parent(parentClass)
    console.log($scoringElement)
    $scoringRow = $scoringElement.parent('.scoringRow')
    #previously set key on row container
    personKey = $scoringRow.data('person')
    $scoreSheet = $scoringElement.find('ul' + className).fadeIn(500)
    $scoreSheet.find('li').touchdown( (event) =>
      $scoreSheet.fadeOut(500)
      #get the data we set in the scoring preload
      touched = $(event.target).data(type)
      #set the current display to what we just touched
      $target.html(touched)

      #set the state's touched answer where the scoringScreen is current
      #and the person's key matches personKey
      @state[scoringScreen][personKey].touched = touched
    )

  endTask: ->

    #there is currently no real event data since
    #this is more of an examiner task
    TabCAT.Task.logEvent(@state)

    TabCAT.Task.finish()

@LearningMemoryTask = class extends MemoryTask
  constructor: ->
    super()

    @currentExampleTrial = 0

    @state = @buildInitialState(["RECALL_ONE", "RECALL_TWO"])

    #generate pre-loaded images to switch out on the fly
    #concat'ing examples for first trials to work with same html
    encounterPeople = @EXAMPLE_PEOPLE.concat(@currentForm.PEOPLE)

    @preloadEncounterImageData($("#screenImage"), encounterPeople)
    @preloadScoringImageData(
      recallOneScoringScreen: @currentForm.RECALL_ONE
      recallTwoScoringScreen: @currentForm.RECALL_TWO
    )

  showStartScreen: ->
    $("#backButton").hide()
    $("#trialScreen").hide()

    $("#rememberOne").hide()

    $("#supplementaryInstruction").hide()

    $("#instructionsScreen").show()
    html = @getTranslatedParagraphs('instructions_before_face')

    $("#instructionsScreen div#instructions").html(html)

    $("#nextButton").unbind().show().touchdown( =>
      @instructionsFavoriteFood()
    )

  instructionsFavoriteFood: ->
    $("#instructionsScreen").hide()
    $("#recallBoth").hide()

    html = @getTranslatedParagraphs('instructions_favorite_food')

    $("#supplementaryInstruction").show().html(html)

    person = @EXAMPLE_PEOPLE[0]

    @showPerson(person)
    $("#rememberOne").show().empty().html(
      '<p>' + person.FOOD + '</p>' )
    $("#trialScreen").show()

    $("#backButton").unbind().show().touchdown( =>
      @showStartScreen()
    )

    $("#nextButton").unbind().show().touchdown( =>
      @instructionsFavoriteAnimal()
    )

  instructionsFavoriteAnimal: ->

    $("#instructionsScreen").hide()
    $("#recallBoth").hide()

    html = @getTranslatedParagraphs('instructions_favorite_animal')

    $("#supplementaryInstruction").show().html(html)

    person = @EXAMPLE_PEOPLE[0]

    @showPerson(person)
    $("#rememberOne").show().empty().html(
      '<p>' + person.ANIMAL + '</p>' )
    $("#trialScreen").show()

    $("#backButton").unbind().show().touchdown( =>
      @instructionsFavoriteFood()
    )

    $("#nextButton").unbind().show().touchdown( =>
      @instructionsRecallBoth()
    )

  instructionsRecallBoth: ->

    $("#trialScreen").show()
    $("#instructionsScreen").hide()

    $("#rememberOne").hide()
    $("#recallBoth").show()
    $("#recallNextButton").hide()

    $("#supplementaryInstruction").hide()

    $("#backButton").unbind().show().touchdown( =>
      @instructionsFavoriteAnimal()
    )

    $("#nextButton").unbind().show().touchdown( =>
      @instructionsRemember()
    )

  instructionsRemember: ->

    $("#instructionsScreen").show()

    html = @getTranslatedParagraphs('instructions_remember')

    $("#instructionsScreen div#instructions").html(html)

    $("#backButton").unbind().show().touchdown( =>
      @instructionsRecallBoth()
    )

    $("#nextButton").unbind().show().touchdown( =>
      @instructionsReady()
    )

  instructionsReady: ->
    $("#nextButton").hide()
    $("#instructionsScreen").show()

    html = @getTranslatedParagraphs('instructions_ready')

    $("#instructionsScreen div#instructions").html(html)

    $("#backButton").unbind().show().touchdown( =>
      @instructionsRemember()
    )

    $("#beginButton").unbind().show().touchdown( =>
      @beginFirstExposureTrials()
    )

  getTranslatedParagraphs: (toTranslate) ->
    translatedText = $.t(toTranslate, {returnObjectTrees: true})
    html = _.map(translatedText, (value, key) ->
      '<p>' + value + '</p>')
    return html

  beginFirstExposureTrials: ->
    $("#beginButton").unbind().hide()
    $("#backButton").unbind().hide()

    @showRememberScreen()
    #generate trials for exposure
    trials = @generateExposureStimuli(@currentForm.FIRST_EXPOSURE)
    $("#nextButton").unbind().show().touchdown( =>
      $("#rememberScreen").hide()
      $("#nextButton").hide()
      @iterateFirstExposureTrials(trials)
    )

  beginSecondExposureTrials: ->
    @showRememberScreen()
    #generate trials for exposure
    trials = @generateExposureStimuli(@currentForm.SECOND_EXPOSURE)
    $("#nextButton").unbind().show().touchdown( =>
      $("#nextButton").hide()
      $("#rememberScreen").hide()
      @iterateSecondExposureTrials(trials)
    )

  beginFirstRecall: ->
    @showBlankScreen()

    trials = @generateRecalls(@currentForm.RECALL_ONE)

    TabCAT.UI.wait(@TIME_BETWEEN_STIMULI).then( =>
      @iterateFirstRecallTrials(trials)
    )

  beginSecondRecall: ->
    @showBlankScreen()

    trials = @generateRecalls(@currentForm.RECALL_TWO)

    TabCAT.UI.wait(@TIME_BETWEEN_STIMULI).then( =>
      @iterateSecondRecallTrials(trials)
    )

  iterateFirstRecallTrials: (trials) ->
    trial = trials.shift()
    @showNextTrial(trial)

    $("#recallNextButton").unbind().touchdown( =>
      if trials.length
        @iterateFirstRecallTrials(trials)
      else
        @beginSecondExposureTrials()
    )

  iterateSecondRecallTrials: (trials) ->

    @showNextTrial(trials.shift())

    $("#recallNextButton").unbind().touchdown( =>
      if trials.length
        @iterateSecondRecallTrials(trials)
      else
        @recallOneScoringScreen()
    )

  iterateFirstExposureTrials: (trials) ->
    @showNextTrial(trials.shift())

    TabCAT.UI.wait(@TIME_BETWEEN_STIMULI).then( =>
      $(".encounterFace").fadeOut(@FADE_OUT_TIME)
      $("#rememberOne").fadeOut(@FADE_OUT_TIME)
    ).then( =>
      if trials.length
        @iterateFirstExposureTrials(trials)
      else
        @beginFirstRecall()
    )

  iterateSecondExposureTrials: (trials) ->
    @showNextTrial(trials.shift())

    TabCAT.UI.wait(@TIME_BETWEEN_STIMULI).then( =>
      $(".encounterFace").fadeOut(@FADE_OUT_TIME)
      $("#rememberOne").fadeOut(@FADE_OUT_TIME)
    ).then( =>
      if trials.length
        @iterateSecondExposureTrials(trials)
      else
        @beginSecondRecall()
    )

  recallOneScoringScreen: ->
    $('#trialScreen').hide()
    $('#backButton').hide()
    $('#recallOneScoringScreen').show()
    $("#completeButton").unbind().hide()
    $("#recallOneScoringScreen")
      .find(".scoringFood span.currentSelection")
      .unbind().touchdown( (event) =>
        @scoringTouchHandler(event, 'food', 'RECALL_ONE')
      )

    $("#recallOneScoringScreen")
      .find(".scoringAnimal span.currentSelection")
      .unbind().touchdown( (event) =>
        @scoringTouchHandler(event, 'animal', 'RECALL_ONE')
      )

    $("#nextButton").unbind().show().touchdown( =>
      $('#recallOneScoringScreen').hide()
      @recallTwoScoringScreen()
    )

    #Trigger Modal Dropdown on Open
    #Recall Scoring One Modals
    personOneModal = $('.personOneModal')
    personTwoModal = $('.personTwoModal')
    personThreeModal = $('.personThreeModal')
    personFourModal = $('.personFourModal')
    personTwoModal.hide()
    personThreeModal.hide()
    personFourModal.hide()
    $('.close').touchdown ->
      $(this).parent().fadeOut 'slow'
    $('.firstModalNext').touchdown ->
      personOneModal.hide()
      personTwoModal.show()
    $('.secondModalNext').touchdown ->
      personTwoModal.hide()
      personThreeModal.show()
    $('.thirdModalNext').touchdown ->
      personThreeModal.hide()
      personFourModal.show()
    $('.fourthModalNext').touchdown ->
      $(this).parent().fadeOut 'slow'
    $('.scoringImageOne').touchdown ->
      personOneModal.show()
    $('.scoringImageTwo').touchdown ->
      personTwoModal.show()
    $('.scoringImageThree').touchdown ->
      personThreeModal.show()
    $('.scoringImageFour').touchdown ->
      personFourModal.show()






  recallTwoScoringScreen: ->
    $('#nextButton').hide()
    $('#recallTwoScoringScreen').show()
    $('#backButton').unbind().show().touchdown( =>
      $('#recallTwoScoringScreen').hide()
      @recallOneScoringScreen()
    )

    $("#recallTwoScoringScreen")
      .find(".scoringFood span.currentSelection")
      .unbind().touchdown( (event) =>
        @scoringTouchHandler(event, 'food', 'RECALL_TWO')
      )

    $("#recallTwoScoringScreen")
      .find(".scoringAnimal span.currentSelection")
      .unbind().touchdown( (event) =>
        @scoringTouchHandler(event, 'animal', 'RECALL_TWO')
      )

    $("#completeButton").unbind().show().touchdown( =>
      #at this point, check to ensure we've answered all questions
      @endTask()
    )


@DelayMemoryTask = class extends MemoryTask
  constructor: ->
    super()

    #generate pre-loaded images to switch out on the fly
    @preloadEncounterImageData($("#screenImage"), @currentForm.PEOPLE)
    @preloadScoringImageData(
      delayedRecallScoringScreen: @currentForm.DELAYED_RECALL
    )

    @state = @buildInitialState(["DELAYED_RECALL"])

  showStartScreen: ->
    $("completeButton").hide()
    @beginDelayedRecall()

  beginDelayedRecall: ->
    trials = @generateRecalls(@currentForm.DELAYED_RECALL)
    @iterateDelayedRecallTrials(trials)

  iterateDelayedRecallTrials: (trials) ->
    @showNextTrial(trials.shift())

    $("#recallNextButton").unbind().touchdown( =>
      if trials.length
        @iterateDelayedRecallTrials(trials)
      else
        @delayedScoringScreen()
    )

  delayedScoringScreen: ->
    $('#trialScreen').hide()
    $('#backButton').hide()
    $('#delayedRecallScoringScreen').show()

    $("#delayedRecallScoringScreen")
      .find(".scoringFood span.currentSelection")
      .unbind().touchdown( (event) =>
        @scoringTouchHandler(event, 'food', 'DELAYED_RECALL')
      )

    $("#delayedRecallScoringScreen")
      .find(".scoringAnimal span.currentSelection")
      .unbind().touchdown( (event) =>
        @scoringTouchHandler(event, 'animal', 'DELAYED_RECALL')
      )

    $("#completeButton").unbind().show().touchdown( =>
      #at this point, check to ensure we've answered all questions
      @endTask()
    )




    
