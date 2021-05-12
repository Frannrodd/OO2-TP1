Class {
	#name : #Question,
	#superclass : #Post,
	#instVars : [
		'title',
		'answers',
		'topics'
	],
	#category : #'OO2-TP1-Model'
}

{ #category : #'instance creation' }
Question class >> title: arg1 Description: arg2 Topics: arg3 [
	| tmp1 |
	tmp1 := self new.
	tmp1
		title: arg1;
		description: arg2.
	^ tmp1 topics: arg3 yourself
]

{ #category : #'instance creation' }
Question class >> title: arg1 Description: arg2 Topics: arg3 User: arg4 [
	| tmp1 |
	tmp1 := self new.
	tmp1
		title: arg1;
		description: arg2;
		user: arg4.
	^ tmp1 topics: arg3 yourself
]

{ #category : #adding }
Question >> addAnswer: arg1 [
	self answers add: arg1
]

{ #category : #'accessing-tests' }
Question >> answerIn: anAnswer [
	^ answers includes: anAnswer
]

{ #category : #accessing }
Question >> answers [
	^ answers
]

{ #category : #testing }
Question >> hasThisTopic: arg1 [
	^ self topics includes: arg1
]

{ #category : #initialization }
Question >> initialize [
	super initialize.
	answers := Set new
]

{ #category : #testing }
Question >> isQuestion [
	^ true
]

{ #category : #accessing }
Question >> title [
	^ title
]

{ #category : #accessing }
Question >> title: arg1 [
	title := arg1
]

{ #category : #'accessing - private' }
Question >> topics [
	^ topics
]

{ #category : #'accessing - private' }
Question >> topics: arg1 [
	topics := arg1
]
