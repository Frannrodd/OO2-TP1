Class {
	#name : #PostTest,
	#superclass : #TestCase,
	#instVars : [
		'user',
		'topic1',
		'topic2',
		'topics1',
		'question1',
		'answer1',
		'user2',
		'user3'
	],
	#category : #'OO2-TP1-Tests'
}

{ #category : #running }
PostTest >> setUp [
	user := User username: 'fran' password: 'fran'.
	user2 := User username: 'manu' password: 'manu'.
	user3 := User username: 'pedro' password: 'pedro'.
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
PostTest >> testAddVote [
	|aVote|
	aVote := Vote userDislikes: user.
	question1 addVote: aVote.
	self assert:( question1 voteIn: aVote) equals: true
]

{ #category : #test }
PostTest >> testCalculateScore [
	self assert: question1 calculateScore equals: 0.
	question1 like: user2.
	self assert: question1 calculateScore equals: 1.
	question1 dislike: user3.
	self assert: question1 calculateScore equals: 0.
	question1 dislike: user2.
	
	self	assert: question1 calculateScore equals: -2.
	self	assert: answer1 calculateScore equals: 0.
	answer1 like: user2.
	self assert: answer1 calculateScore equals: 1.
	answer1 dislike: user3.
	self assert: answer1 calculateScore equals: 0.
	answer1 dislike: user2.
	self assert: answer1 calculateScore equals: -2
]

{ #category : #test }
PostTest >> testDislike [
	self assert: question1 quantityOfDislikes equals: 0.
	question1 dislike: user2.
	self assert: question1 quantityOfDislikes equals: 1.
	self assert: answer1 quantityOfDislikes equals: 0.
	answer1 dislike: user2.
	self assert: answer1 quantityOfDislikes equals: 1
]

{ #category : #test }
PostTest >> testLike [
	self assert: question1 quantityOfLikes equals: 0.
	question1 like: user2.
	self assert: question1 quantityOfLikes equals: 1.
	self assert: answer1 quantityOfLikes equals: 0.
	answer1 like: user2.
	self assert: answer1 quantityOfLikes equals: 1
]

{ #category : #test }
PostTest >> testQuantityOfDislikes [
	self assert: question1 quantityOfDislikes equals: 0.
	question1 dislike: user2.
	self assert: question1 quantityOfDislikes equals: 1.

]

{ #category : #test }
PostTest >> testQuantityOfLikes [
	self assert: question1 quantityOfLikes equals: 0.
	question1 like: user2.
	self assert: question1 quantityOfLikes equals: 1.
	
]

{ #category : #test }
PostTest >> testRemoveFromDislikes [
	question1 dislike: user2.
	self assert: question1 quantityOfDislikes equals: 1.
	question1 removeFromDislikes: user2.
	self assert: question1 quantityOfDislikes equals: 0.

]

{ #category : #test }
PostTest >> testRemoveFromLikes [
	question1 like: user2.
	self assert: question1 quantityOfLikes equals: 1.
	question1 removeFromLikes: user2.
	self assert: question1 quantityOfLikes equals: 0.
	
]
