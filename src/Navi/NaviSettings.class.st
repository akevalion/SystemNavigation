"
Use this class to add new settings to the world menu
"
Class {
	#name : #NaviSettings,
	#superclass : #Object,
	#category : #Navi
}

{ #category : #'world menu' }
NaviSettings class >> worldMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'Update windows layout')
		parent: #Windows;
		order: 0;
		help: 'Navi will update the windows for you :V';
		icon: (self iconNamed: #image);
		action: [ SystemWindow layoutWindows ]
]
