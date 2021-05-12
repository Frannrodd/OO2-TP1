Class {
	#name : #UserTest,
	#superclass : #TestCase,
	#instVars : [
		'user',
		'topic1',
		'topic2',
		'topics1',
		'topics2',
		'topic3',
		'question1',
		'user2',
		'user3',
		'answer1'
	],
	#category : #'OO2-TP1-Tests'
}

{ #category : #running }
UserTest >> setUp [
	user := User username: 'fran' password: 'fran'.
	user2 := User username: 'manu' password: 'manu'.
	user3 := User username: 'pedro' password: 'pedro'.
	topic1 := Topic title: 'Electronica' description: 'musica'.
	topic2 := Topic title: 'Jazz' description: 'musica'.
	topic3 := Topic title: 'Rock' description: 'musica'.
	topics1 := Set with: topic1.
	topics2 := Set with: topic2 with: topic3.
	user
		addQuestionTitle: 'Cuantos discos tiene Daft Punk?'
		Description: 'Discos'
		Topics: topics1.
	question1 := Question
		title: 'Alguien me recomienda una buena banda de jazz?'
		Description: 'Bandas de jazz'
		Topics: topics2
		User: user.
	answer1 := Answer
		description: 'Depende donde lo hagas y de que manera'
		User: user
]

{ #category : #test }
UserTest >> testAddAnswerQuestionDescription [
	| tmp1 tmp2 |
	tmp1 := self.
	tmp1
		assert: user answers size equals: 0;
		assert: question1 answers size equals: 0.
	user addAnswerQuestion: question1 Description: 'Creo que tienen 6 albums'.
	tmp2 := self.
	tmp2
		assert: user answers size equals: 1;
		assert: question1 answers size equals: 1;
		assert: user posts size equals: 2
]

{ #category : #test }
UserTest >> testAddFollowing [
	self assert: user following size equals: 0.
	user addFollowing: user2.
	self assert: user following size equals: 1
]

{ #category : #test }
UserTest >> testAddInterestingTopic [
	
	user addInterestingTopic: topic1.
	self assert: (user interestingTopicsIn: topic1 ) equals: true
]

{ #category : #test }
UserTest >> testAddPost [
	user addPost: question1.

	self assert: (user postIn: question1) equals: true.
]

{ #category : #test }
UserTest >> testAddQuestionTitleDescriptionTopics [
	self assert: user questions size equals: 1.
	user
		addQuestionTitle: 'alguien conoce un buen artista de jazz?'
		Description: 'me gustaria saberlo'
		Topics: topics2.
	self assert: user questions size equals: 2
]

{ #category : #test }
UserTest >> testAnswers [
	user addPost: answer1.
	self assert: (user answerIn: answer1) equals: true.
]

{ #category : #test }
UserTest >> testCalculateScore [
	self assert: user calculateScore equals: 20.
	user addAnswerQuestion: question1 Description: 'Creo que tienen 6 albums'.
	self assert: user calculateScore equals: 70.
	user
		addQuestionTitle: 'alguien conoce un buen artista de jazz?'
		Description: 'me gustaria saberlo'
		Topics: topics2.
	self assert: user calculateScore equals: 90.
	user addPost: question1.
	question1 like: user2.
	self assert: user calculateScore equals: 111.
	question1 dislike: user3.
	self assert: user calculateScore equals: 110
]

{ #category : #test }
UserTest >> testDeleteThisquestion [
	user addPost: question1.
	self assert:(user postIn: question1) equals: true.
	user deleteThisquestion: question1.
	self assert:(user postIn: question1) equals: false.
]

{ #category : #test }
UserTest >> testQuestions [
	user addPost: question1 .
	self assert: (user questionIn: question1) equals: true
]

{ #category : #test }
UserTest >> testQuestionsOfATopic [
	| tmp2 |
	tmp2 := self.
	tmp2
		assert: (user questionsOfATopic: topic1) size equals: 1;
		assert: (user questionsOfATopic: topic2) size equals: 0
]

{ #category : #test }
UserTest >> testRemoveFollowing [
	user addFollowing: user2.
	self assert: (user followIn: user2) equals: true.
	user removeFollowing: user2.
	self assert: (user followIn: user2) equals: false.
]
