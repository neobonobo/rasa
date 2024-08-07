version: "3.1"

nlu:
- intent: greet
  examples: |
    - hey
    - hello
    - hi
    - hello there
    - good morning
    - good evening
    - hey there
    - goodmorning
    - goodevening
    - good afternoon

- intent: ask_tahini_availability
  examples: |
    - Do you have tahini?
    - Can I get tahini here?
    - Is tahini available?
    - Do you sell tahini?

- intent: ask_tahini_availability_tr
  examples: |
    - Tahin var mı?
    - Tahin satıyor musunuz?
    - Burada tahin bulabilir miyim?
    - Tahin mevcut mu?
    - Tahin var mı?
    - Elinizde tahin var mı?

- intent: ask_tahini_price
  examples: |
    - How much is the tahini?
    - What's the price of tahini?
    - How much does tahini cost?
    - Can you tell me the price of tahini?

- intent: ask_tahini_price_tr
  examples: |
    - Tahin ne kadar?
    - Tahin fiyatı nedir?

- intent: buy_tahini
  examples: |
    - I want to buy tahini
    - I would like to purchase some tahini
    - Can I buy tahini?
    - I need to order tahini

- intent: buy_tahini_tr
  examples: |
    - Tahin satın almak istiyorum
    - Tahin almak istiyorum

- intent: goodbye
  examples: |
    - cu
    - good by
    - cee you later
    - good night
    - bye
    - goodbye
    - have a nice day
    - see you around
    - bye bye
    - see you later

- intent: affirm
  examples: |
    - yes
    - y
    - indeed
    - of course
    - that sounds good
    - correct

- intent: deny
  examples: |
    - no
    - n
    - never
    - I don't think so
    - don't like that
    - no way
    - not really

- intent: mood_great
  examples: |
    - perfect
    - great
    - amazing
    - feeling like a king
    - wonderful
    - I am feeling very good
    - I am great
    - I am amazing
    - I am going to save the world
    - super stoked
    - extremely good
    - so so perfect
    - so good
    - so perfect

- intent: mood_unhappy
  examples: |
    - my day was horrible
    - I am sad
    - I don't feel very well
    - I am disappointed
    - super sad
    - I'm so sad
    - sad
    - very sad
    - unhappy
    - not good
    - not very good
    - so sad

- intent: bot_challenge
  examples: |
    - are you a bot?
    - are you a human?
    - am I talking to a bot?
    - am I talking to a human?

version: "3.1"

intents:
  - greet
  - goodbye
  - affirm
  - deny
  - mood_great
  - mood_unhappy
  - bot_challenge
  - ask_tahini_price
  - ask_tahini_price_tr
  - buy_tahini
  - buy_tahini_tr
  - ask_tahini_availability
  - ask_tahini_availability_tr

responses:
  utter_ask_tahini_price:
    - text: "Our tahini is 300 TL per jar."

  utter_ask_tahini_price_tr:
    - text: "Tahin fiyatımız 660cc'lik kavanoz için 300 liradır."

  utter_buy_tahini:
    - text: "Great! You can place your order on https://www.shopier.com/koycebiz."

  utter_buy_tahini_tr:
    - text: "Harika! https://www.shopier.com/koycebiz linkinden satın alabilirsiniz."

  utter_ask_tahini_availability:
    - text: "Yes, we have tahini available."

  utter_ask_tahini_availability_tr:
    - text: "Evet, tahinimiz mevcut."

  utter_greet:
    - text: "Hey! How are you?"
    - text: "Merhaba! Nasılsınız?"

  utter_cheer_up:
    - text: "Here is something to cheer you up:"
      image: "https://i.imgur.com/nGF1K8f.jpg"
    - text: "İşte sizi neşelendirecek bir şey:"
      image: "https://i.imgur.com/nGF1K8f.jpg"

  utter_did_that_help:
    - text: "Did that help you?"
    - text: "Bu size yardımcı oldu mu?"

  utter_happy:
    - text: "Great, carry on!"
    - text: "Harika, devam edin!"

  utter_goodbye:
    - text: "Bye"
    - text: "Hoşça kal"

  utter_iamabot:
    - text: "I am a bot, powered by Rasa."
    - text: "Ben bir botum, Rasa tarafından destekleniyorum."

session_config:
  session_expiration_time: 60
  carry_over_slots_to_new_session: true
version: "3.1"

stories:

- story: greet and ask tahini price
  steps:
  - intent: greet
  - action: utter_greet
  - intent: ask_tahini_price
  - action: utter_ask_tahini_price

- story: ask tahini price in Turkish
  steps:
  - intent: ask_tahini_price_tr
  - action: utter_ask_tahini_price_tr

- story: buy tahini
  steps:
  - intent: buy_tahini
  - action: utter_buy_tahini

- story: buy tahini in Turkish
  steps:
  - intent: buy_tahini_tr
  - action: utter_buy_tahini_tr

- story: greet and ask if tahini is available
  steps:
  - intent: greet
  - action: utter_greet
  - intent: ask_tahini_availability
  - action: utter_ask_tahini_availability

- story: ask if tahini is available in Turkish
  steps:
  - intent: ask_tahini_availability_tr
  - action: utter_ask_tahini_availability_tr

- story: happy path
  steps:
  - intent: greet
  - action: utter_greet
  - intent: mood_great
  - action: utter_happy

- story: sad path 1
  steps:
  - intent: greet
  - action: utter_greet
  - intent: mood_unhappy
  - action: utter_cheer_up
  - action: utter_did_that_help
  - intent: affirm
  - action: utter_happy

- story: sad path 2
  steps:
  - intent: greet
  - action: utter_greet
  - intent: mood_unhappy
  - action: utter_cheer_up
  - action: utter_did_that_help
  - intent: deny
  - action: utter_goodbye
version: "3.1"

language: en

pipeline:
- name: WhitespaceTokenizer
- name: RegexFeaturizer
- name: LexicalSyntacticFeaturizer
- name: CountVectorsFeaturizer
- name: CountVectorsFeaturizer
  analyzer: char_wb
  min_ngram: 1
  max_ngram: 4
- name: DIETClassifier
  epochs: 20    # Reduce number of epochs
  batch_size: 64    # Adjust batch size
  constrain_similarities: true
  optimizer: "tf.keras.optimizers.legacy.Adam"
- name: EntitySynonymMapper
- name: ResponseSelector
  epochs: 20    # Reduce number of epochs
  constrain_similarities: true
  optimizer: "tf.keras.optimizers.legacy.Adam"
- name: FallbackClassifier
  threshold: 0.3
  ambiguity_threshold: 0.1

policies:
- name: MemoizationPolicy
- name: RulePolicy
- name: UnexpecTEDIntentPolicy
  max_history: 5
  epochs: 20    # Reduce number of epochs
- name: TEDPolicy
  max_history: 5
  epochs: 20    # Reduce number of epochs
  constrain_similarities: true
assistant_id: 20240807-151103-resolving-raid
