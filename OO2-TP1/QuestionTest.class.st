Class {
	#name : #QuestionTest,
	#superclass : #TestCase,
	#instVars : [
		'user',
		'topics2',
		'question1',
		'topic1',
		'topic2',
		'topics1',
		'answer1'
	],
	#category : #'OO2-TP1-Tests'
}

{ #category : #running }
QuestionTest >> setUp [
	user := User username: 'fran' password: 'fran'.
	topic1 := Topic title: 'Asado' description: 'comida'.
	topic2 := Topic title: 'Pizza' description: 'comida'.
	topics1 := Set with: topic1.
	question1 := Question
		title: 'Que tan dificil es hacer un asado?'
		Description: 'hay muchas maneras de hacerlos'
		Topics: topics1
		User: user.
	answer1 := Answer description: 'Depende donde lo hagas y de que manera' User: user
]

{ #category : #test }
QuestionTest >> testAddAnswer [
	question1 addAnswer: answer1.
	self assert: (question1 answerIn: answer1) equals: true
]

{ #category : #test }
QuestionTest >> testHasThisTopic [
	self assert: (question1 hasThisTopic: topic1) equals: true.
	self assert: (question1 hasThisTopic: topic2) equals: false
]
