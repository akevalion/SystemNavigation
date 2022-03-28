Extension { #name : #SystemWindow }

{ #category : #'*Navi' }
SystemWindow class >> defaultLineItemsCount [ 
	^ [ :elements | 
			| height width |
			elements size <= 3 
				ifTrue: [ (elements size max: 1) @ 1 ]
				ifFalse: 
					[ height := (elements size * 0.618034) sqrt ceiling truncated.
					width := (elements size / height) ceiling truncated.
					width @ height ] ]
]

{ #category : #'*Navi' }
SystemWindow class >> layoutWindows [
	| windows extent worldExtent winExtent deltaPoint world |
	[windows := (self withAllSubclasses flatCollect: #allInstances) select: [:win | win world notNil].
	windows ifEmpty: [ ^ self ].
	
	world := windows anyOne world.
	windows := world submorphs select: [ :win | win isKindOf: SystemWindow ].
	extent := self defaultLineItemsCount value: windows.
	worldExtent := windows anyOne world extent - (20 @ 50).
	
	winExtent := worldExtent / extent.
	deltaPoint := 10 @ 25.
	(0 to: extent y-1) do: [ :y |
		(0 to: extent x-1) do: [ :x  |
			| index window |
			index := y*extent x + x + 1.
			(index between: 1 and: windows size) ifTrue: [ 
				window := windows at: index.
				window position: deltaPoint + (winExtent * ((x @ y ))).
				window extent: winExtent.
				 ].
			 ].
		 ]
	] onErrorDo: [ :ex | 'layoutWindows' traceCr . ex traceCr ].
]

{ #category : #'*Navi' }
SystemWindow >> postOpenInWorld: aWorld [

	self activate.
	super postOpenInWorld: aWorld.
	self class layoutWindows.
]
