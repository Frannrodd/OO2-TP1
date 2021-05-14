Class {
	#name : #LoginComponent,
	#superclass : #WAComponent,
	#instVars : [
		'user',
		'users',
		'username',
		'password'
	],
	#category : #'OO2-TP1-View'
}

{ #category : #'as yet unclassified' }
LoginComponent class >> initialize [
	| tmp1 |
	tmp1 := WAAdmin register: self asApplicationAt: 'CuOOra'.
	tmp1 sessionClass: SessionWithUser
]

{ #category : #'as yet unclassified' }
LoginComponent class >> onLogIn: arg1 [
	^ self new
		on: (User username: 'enter your username' password: 'enter your Password')
		and: arg1
]

{ #category : #'as yet unclassified' }
LoginComponent >> cancel [
	user := nil.
	self answer
]

{ #category : #'as yet unclassified' }
LoginComponent >> home [
	| tmp1 tmp2 |
	tmp2 := users
		select: [ :arg1 | arg1 username = username and: arg1 password = password ].
	tmp2 isEmpty
		ifTrue: [ user := nil ]
		ifFalse: [ self session user: tmp2 first.
			tmp1 := CuOOraComponent new.
			self call: tmp1 ]
]

{ #category : #'as yet unclassified' }
LoginComponent >> initialize [
	super initialize. 
	username := 'enter your username'.
	password := 'enter your Password'.
	users := CuOOra soleInstance users.
	self session user ifNotNil: [ self home ]
]

{ #category : #'as yet unclassified' }
LoginComponent >> on: arg1 and: arg2 [
	user := arg1.
	username := user username.
	password := user password.
	users := arg2
]

{ #category : #'as yet unclassified' }
LoginComponent >> password [
	^ password
]

{ #category : #'as yet unclassified' }
LoginComponent >> password: arg1 [
	password := arg1
]

{ #category : #'as yet unclassified' }
LoginComponent >> renderContentOn: aCanvas [
| section |
	aCanvas
		heading: 'CuOOra';
		break;
		form: [ 
			aCanvas text: 'Username: '.
			aCanvas textInput on: #username of: self.
			aCanvas
				break;
				text: 'Password: '.
			aCanvas textInput on: #password of: self.
			aCanvas break.
			section := aCanvas submitButton.
			section
				callback: [ self home ];
				value: 'Iniciar sesion' ]
]

{ #category : #'as yet unclassified' }
LoginComponent >> user [
	^ user
]

{ #category : #'as yet unclassified' }
LoginComponent >> username [
	^ username
]

{ #category : #'as yet unclassified' }
LoginComponent >> username: arg1 [
	username := arg1
]
