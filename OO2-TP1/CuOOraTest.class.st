Class {
	#name : #CuOOraTest,
	#superclass : #TestCase,
	#instVars : [
		'user',
		'topic1',
		'cuoora',
		'topic2',
		'topic3',
		'topics1',
		'user1',
		'question1',
		'question2',
		'answer1',
		'answer2'
	],
	#category : #'OO2-TP1-Tests'
}

{ #category : #running }
CuOOraTest >> setUp [
	cuoora := CuOOra new.
	user := User
		username: 'pedro@cuoora.com'
		password: 'pedro@cuoora.com'.
	user1 := User username: 'fran' password: 'fran'.
	topic1 := Topic title: 'Hamburguesas' description: 'Comida'.
	topic2 := Topic title: 'Fideos' description: 'Comida'.
	topics1 := Set with: topic1.
	user1 addInterestingTopic: topic1.
	user1 addFollowing: user.
	user addFollowing: user1.
	user1
		addQuestionTitle: 'Como se hace una buena hamburguesa?'
		Description: 'Me gustaria saberlo'
		Topics: topics1.
	cuoora addUser: user1.
	cuoora addUser: user.
	question1 := Question
		title: 'Alguien me recomienda una buena banda de jazz?'
		Description: 'Bandas de jazz'
		Topics: topics1
		User: user.
	question2 := Question
		title: 'Como se hace una buena hamburguesa?'
		Description: 'Me gustaria saberlo'
		Topics: topics1
		User: user1.
	user addPost: question1.
	answer1 := Answer
		description: 'Depende donde lo hagas y de que manera'
		User: user1
]

{ #category : #test }
CuOOraTest >> testAddTopic [
	cuoora addTopic: topic1.
	self assert: (cuoora topicIn: topic1) equals: true
]

{ #category : #test }
CuOOraTest >> testAddUser [

	cuoora addUser: user.
	self assert: (cuoora userIn: user) equals: true
]

{ #category : #tests }
CuOOraTest >> testAnswersFromAnUser [
	| answers |
	user addPost: answer1.
	answers := OrderedCollection new.
	answers add: answer1.
	self assert: (cuoora answersFromAnUser: user )equals: answers
]

{ #category : #test }
CuOOraTest >> testCreateNewUserPassword [
	self assert: cuoora users size equals: 2.
	cuoora createNewUser: 'manu' Password: 'manu'.
	self assert: cuoora users size equals: 3
]

{ #category : #test }
CuOOraTest >> testCreateTopicDescription [
	self assert: cuoora topics size equals: 0.
	cuoora createTopic: 'hamburguesa' Description: 'comida'.
	self assert: cuoora topics size equals: 1
]

{ #category : #test }
CuOOraTest >> testFindOrCreate [
	cuoora findOrCreate: topic2.
	self assert: (cuoora topicIn: topic2) equals: true
]

{ #category : #test }
CuOOraTest >> testGetAllFollowingQuestions [
	self
		assert:
			((cuoora getAllFollowingQuestions: user1 following)
				includes: question1)
		equals: true.
			self
		assert:
			((cuoora getAllFollowingQuestions: user1 following)
				includes: question2)
		equals: false
]

{ #category : #test }
CuOOraTest >> testGetAllQuestionsOfTopics [
	self
		assert:
			((cuoora getAllQuestionsOfTopics: user1 interestingTopics)
				includes: question1)
		equals: true.
		self
		assert:
			((cuoora getAllQuestionsOfTopics: user1 following)
				includes: question2)
		equals: false
]

{ #category : #test }
CuOOraTest >> testInterestingQuestionsForAnUser [
	self
		assert: ((cuoora interestingQuestionsForAnUser: user1) includes: question1)
		equals: true.
			self
		assert: ((cuoora interestingQuestionsForAnUser: user1) includes: question2)
		equals: false
]

{ #category : #test }
CuOOraTest >> testQuestionsFromAnUser [
	| questions |
	questions := OrderedCollection new.
	questions add: question1.
	self assert: (cuoora questionsFromAnUser: user) equals: questions
]

{ #category : #test }
CuOOraTest >> testQuestionsWithATopic [
	| tmp1 |
	self assert: (cuoora questionsWithATopic: topic2) size equals: 0.
	tmp1 := Set with: topic2.
	user1
		addQuestionTitle: 'Como se hace una buena hamburguesa?'
		Description: 'Me gustaria saberlo'
		Topics: tmp1.
	self assert: (cuoora questionsWithATopic: topic2) size equals: 1
]
