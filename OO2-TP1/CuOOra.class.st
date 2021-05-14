Class {
	#name : #CuOOra,
	#superclass : #Object,
	#instVars : [
		'users',
		'topics'
	],
	#classInstVars : [
		'soleInstance'
	],
	#category : #'OO2-TP1-Model'
}

{ #category : #'instance creation' }
CuOOra class >> clearSoleInstance [
	soleInstance := nil
]

{ #category : #'instance creation' }
CuOOra class >> soleInstance [
	soleInstance
		ifNil: [ soleInstance := self new initializeSoleInstance ].
	^ soleInstance
]

{ #category : #accessing }
CuOOra >> addTopic: arg1 [
	self topics add: arg1
]

{ #category : #adding }
CuOOra >> addUser: arg1 [
	self users add: arg1
]

{ #category : #accessing }
CuOOra >> answersFromAnUser: anUser [
	^ anUser answers
]

{ #category : #'instance creation' }
CuOOra >> createNewUser: anUsername Password: aPassword [ 
	self addUser: (User username: anUsername password: aPassword)
]

{ #category : #accessing }
CuOOra >> createTopic: aTitle Description: aDescription [
	| aTopic |
	aTopic := Topic title: aTitle description: aDescription.
	self addTopic: aTopic.
	^ aTopic
]

{ #category : #'instance creation' }
CuOOra >> findOrCreate: topic [
	self topics
		detect: topic
		ifFound: [ ^ topic ]
		ifNone: [ self addTopic: topic ]
]

{ #category : #'accessing-testing' }
CuOOra >> getAllFollowingQuestions: aFollowedCollection [
	^ (aFollowedCollection collectAll: [ :user | user questions ])
	
]

{ #category : #'accessing-testing' }
CuOOra >> getAllQuestionsOfTopics: aTopicCollection [
	^ aTopicCollection
		collectAll: [ :topic | self questionsWithATopic: topic ] 
]

{ #category : #accessing }
CuOOra >> initialize [
	users := OrderedCollection new.
	topics := Set new
]

{ #category : #accessing }
CuOOra >> initializeSoleInstance [
	| tmp1 tmp2 tmp3 tmp4 tmp5 tmp6 tmp7 tmp8 tmp9 tmp10 tmp11 tmp12 tmp13 |
	tmp1 := User
		username: 'pedro@cuoora.com'
		password: 'pedro@cuoora.com'.
	tmp2 := User
		username: 'diego@cuoora.com'
		password: 'diego@cuoora.com'.
	tmp3 := User username: 'juan@cuoora.com' password: 'juan@cuoora.com'.
	tmp4 := self.
	tmp4
		addUser: tmp1;
		addUser: tmp2;
		addUser: tmp3.
	tmp5 := tmp4
		createTopic: 'OO1'
		Description: 'Orientacion a objetos 1'.
	tmp6 := tmp4 createTopic: 'Test de Unidad' Description: 'tema OO1'.
	tmp7 := tmp4 createTopic: 'Smalltalk' Description: 'tema OO1'.
	tmp8 := OrderedCollection with: tmp5 with: tmp6.
	tmp9 := OrderedCollection with: tmp5 with: tmp7.
	tmp10 := Question
		title: '¿Para que sirve el metodo SetUp?'
		Description: 'Lo necesito saber rapido'
		Topics: tmp8
		User: tmp1.
	tmp11 := Answer
		description: 'Sirve para instanciar los objetos que son evaluados por el test en un 				único método y que se ejecute siempre antes de cada test.'
		User: tmp2.
	tmp10 addAnswer: tmp11.
	tmp2 addPost: tmp11.
	tmp1 addPost: tmp10.
	tmp12 := Question
		title: '¿Qué significa #messageNotUnderstood?'
		Description: 'lo quiero saber'
		Topics: tmp9
		User: tmp2.
	tmp13 := Answer
		description: 'significa que el objeto que recibio el mensaje no encontro ningun metodo 				para ejecutar en respuesta'
		User: tmp1.
	tmp12 addAnswer: tmp13.
	tmp2 addPost: tmp12.
	tmp1 addPost: tmp13.
	tmp3 addFollowing: tmp2.
	tmp1 addFollowing: tmp3
]

{ #category : #'instance creation' }
CuOOra >> interestingQuestionsForAnUser: anUser [
	| tmp1 |
	tmp1 := self getAllFollowingQuestions: anUser following.
	tmp1 addAll: (self getAllQuestionsOfTopics: anUser interestingTopics).
	^ tmp1 asSet
]

{ #category : #accessing }
CuOOra >> questionsFromAnUser: arg1 [
	^ arg1 questions
]

{ #category : #accessing }
CuOOra >> questionsWithATopic: arg1 [
	^ self users
		flatCollect: [ :arg2 | arg2 questionsOfATopic: arg1 ].
	
]

{ #category : #'accessing-testing' }
CuOOra >> selectUser: aUser [
	^ users select: [ :arg1 | arg1 username = aUser username and: arg1 password = aUser password ]
]

{ #category : #'accessing-testing' }
CuOOra >> topicIn: aTopic [
	^topics includes: aTopic
]

{ #category : #accessing }
CuOOra >> topics [
	^ topics
]

{ #category : #'accessing-testing' }
CuOOra >> userIn: aUser [
	^ self users includes: aUser
]

{ #category : #accessing }
CuOOra >> users [
	^ users
]
