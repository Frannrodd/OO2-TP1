Class {
	#name : #Topic,
	#superclass : #Object,
	#instVars : [
		'title',
		'description'
	],
	#category : #'OO2-TP1-Model'
}

{ #category : #'instance creation' }
Topic class >> title: arg1 description: arg2 [
	| tmp2 |
	tmp2 := self new.
	tmp2 title: arg1.
	^ tmp2 description: arg2 yourself
]

{ #category : #accessing }
Topic >> description [
	^ description
]

{ #category : #accessing }
Topic >> description: arg1 [
	description := arg1
]

{ #category : #accessing }
Topic >> title [
	^ title
]

{ #category : #accessing }
Topic >> title: arg1 [
	title := arg1
]
