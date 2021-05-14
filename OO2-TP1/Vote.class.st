Class {
	#name : #Vote,
	#superclass : #Object,
	#instVars : [
		'timestamp',
		'user',
		'status'
	],
	#category : #'OO2-TP1-Model'
}

{ #category : #'as yet unclassified' }
Vote class >> userDislikes: arg1 [
	| tmp1 |
	tmp1 := self new.
	tmp1 user: arg1.
	tmp1 dislike.
	^ tmp1 yourself
]

{ #category : #'as yet unclassified' }
Vote class >> userLikes: arg1 [
	| tmp2 |
	tmp2 := self new.
	tmp2 user: arg1.
	tmp2 like.
	^ tmp2 yourself
]

{ #category : #initialization }
Vote >> dislike [
	status := false
]

{ #category : #initialization }
Vote >> initialize [
	timestamp := DateAndTime now
]

{ #category : #initialization }
Vote >> isLike [
	^ status
]

{ #category : #initialization }
Vote >> like [
	status := true
]

{ #category : #initialization }
Vote >> user [
	^ user
]

{ #category : #initialization }
Vote >> user: arg1 [
	user := arg1
]
