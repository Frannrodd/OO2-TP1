Class {
	#name : #User,
	#superclass : #Object,
	#instVars : [
		'username',
		'password',
		'creationDate',
		'posts',
		'following',
		'interestingTopics'
	],
	#category : #'OO2-TP1-Model'
}

{ #category : #'instance creation' }
User class >> username: arg1 password: arg2 [
	| tmp1 |
	tmp1 := self new.
	tmp1 username: arg1.
	^ tmp1 password: arg2 yourself
]

{ #category : #adding }
User >> addAnswerQuestion: aQuestin Description: aDescription [ 
	| anAnswer  |
	anAnswer := Answer description: aDescription User: self.
	self addPost: anAnswer.
	aQuestin addAnswer: anAnswer
]

{ #category : #adding }
User >> addFollowing: anUser [
	self following add: anUser
]

{ #category : #adding }
User >> addInterestingTopic: aTopic [
	self interestingTopics add: aTopic
]

{ #category : #adding }
User >> addPost: arg1 [
	self posts add: arg1
]

{ #category : #adding }
User >> addQuestionTitle: arg1 Description: arg2 Topics: arg3 [
	self
		addPost:
			(Question
				title: arg1
				Description: arg2
				Topics: arg3
				User: self)
]

{ #category : #'accessing-testing' }
User >> answerIn: anAnswer [ 
	^ self answers includes: anAnswer .
]

{ #category : #accessing }
User >> answers [
	^ self posts reject: [ :arg1 | arg1 isQuestion ]
]

{ #category : #'accessing-calculated' }
User >> calculateScore [
	| tmp1 |
	tmp1 := self posts
		inject: 0
		into: [ :arg1 :arg2 | arg1 + arg2 calculateScore ].
	tmp1 := tmp1 + (self questions size * 20).
	tmp1 := tmp1 + (self answers size * 50).
	^ tmp1
]

{ #category : #accessing }
User >> creationDate [
	^ creationDate
]

{ #category : #removing }
User >> deleteThisquestion: aPost [
		(posts  includes: aPost) ifTrue: [self posts remove: aPost  ]
	
]

{ #category : #'accessing-testing' }
User >> followIn: anUser [
	^ following includes: anUser
]

{ #category : #accessing }
User >> following [
	^ following
]

{ #category : #initialization }
User >> initialize [
	interestingTopics := Set new.
	following := Set new.
	posts := OrderedCollection new.
	creationDate := DateAndTime today
]

{ #category : #accessing }
User >> interestingTopics [
	^ interestingTopics
]

{ #category : #'accessing-testing' }
User >> interestingTopicsIn: aTopic [
	^ interestingTopics includes: aTopic.
]

{ #category : #accessing }
User >> password [
	^ password
]

{ #category : #accessing }
User >> password: aPassword [
	password := aPassword
]

{ #category : #'accessing-testing' }
User >> postIn: aPost [
	^ posts includes: aPost
]

{ #category : #accessing }
User >> posts [
	^ posts
]

{ #category : #'accessing-testing' }
User >> questionIn: aQuestion [
	^ self questions includes: aQuestion
]

{ #category : #accessing }
User >> questions [
	^ self posts select: [ :arg1 | arg1 isQuestion ]
]

{ #category : #accessing }
User >> questionsOfATopic: aTopic [
	^ self questions select: [ :question | question hasThisTopic: aTopic ]
]

{ #category : #adding }
User >> removeFollowing: anUser [
	(following includes: anUser )ifTrue: [ self following remove: anUser ]
	
]

{ #category : #accessing }
User >> username [
	^ username
]

{ #category : #accessing }
User >> username: arg1 [
	username := arg1
]
