Class {
	#name : #Answer,
	#superclass : #Post,
	#category : #'OO2-TP1-Model'
}

{ #category : #'instance creation' }
Answer class >> description: arg1 [
	| tmp1 |
	tmp1 := self new.
	^ tmp1 description: arg1 yourself
]

{ #category : #'instance creation' }
Answer class >> description: arg1 User: arg2 [
	| tmp1 |
	tmp1 := self new.
	tmp1 description: arg1.
	^ tmp1 user: arg2 yourself
]

{ #category : #testing }
Answer >> isQuestion [
	^ false
]
