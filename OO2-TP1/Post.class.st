Class {
	#name : #Post,
	#superclass : #Object,
	#instVars : [
		'description',
		'creationDate',
		'user',
		'votes'
	],
	#category : #'OO2-TP1-Model'
}

{ #category : #accessing }
Post >> addVote: aVote [
	votes add: aVote
]

{ #category : #'accessing-calculated' }
Post >> calculateScore [
	^ self quantityOfLikes - self quantityOfDislikes
]

{ #category : #accessing }
Post >> creationDate [
	^ creationDate
]

{ #category : #accessing }
Post >> description [
	^ description
]

{ #category : #accessing }
Post >> description: aDescription [
	description := aDescription
]

{ #category : #adding }
Post >> dislike: aVote [
	((self dislikes collect: [ :arg2 | arg2 user ]) includes: aVote)
		ifFalse: [ self
				removeFromLikes: aVote;
				addVote: (Vote userDislikes: aVote) ]
]

{ #category : #accessing }
Post >> dislikes [
	^ votes reject: [ :arg1 | arg1 isLike ]
]

{ #category : #initialization }
Post >> initialize [
	creationDate := DateAndTime today.
	votes := Set new
]

{ #category : #testing }
Post >> isQuestion [
	self subclassResponsibility 
]

{ #category : #adding }
Post >> like: aVote [
	((self likes collect: [ :arg2 | arg2 user ]) includes: aVote)
		ifFalse: [ self
				removeFromDislikes: aVote;
				addVote: (Vote userLikes: aVote) ]
]

{ #category : #accessing }
Post >> likes [
	^ votes select: [ :arg1 | arg1 isLike ]
]

{ #category : #'accessing-calculated' }
Post >> quantityOfDislikes [
	^ self dislikes size
]

{ #category : #'accessing-calculated' }
Post >> quantityOfLikes [
	^ self likes size
]

{ #category : #adding }
Post >> removeFromDislikes: arg1 [
	| tmp1 |
	((self dislikes collect: [ :arg2 | arg2 user ]) includes: arg1)
		ifFalse: [ ^ self ].
	tmp1 := (self dislikes select: [ :arg3 | arg3 user = arg1 ])
		asOrderedCollection first.
	self votes remove: tmp1
]

{ #category : #adding }
Post >> removeFromLikes: anUser [
	| aVote |
	((self likes collect: [ :arg2 | arg2 user ]) includes: anUser)
		ifFalse: [ ^ self ].
	aVote := (self likes select: [ :arg3 | arg3 user = anUser ])
		asOrderedCollection first.
	self votes remove: aVote
]

{ #category : #'accessing - private' }
Post >> user: arg1 [
	user := arg1
]

{ #category : #'accessing-tests' }
Post >> voteIn: aVote [
	^votes  includes: aVote
]

{ #category : #accessing }
Post >> votes [
	^ votes
]
