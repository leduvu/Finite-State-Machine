%---------------------------------
% Aufgabe 6 - Semesteraufgaben 2013
% Le Duyen Sandra, Vu - 768693
%---------------------------------

% Die Anfrage "start." gibt 3 Beispielanfragen und dessen Ausgabe heraus.
 
start :-
	write('Anfrage 1: analysiere(geholfen, E)'), nl, 
	analysiere(geholfen, E), write(E), nl,nl,
	 
	write('Anfrage 2: analysiere(hilft, F)'), nl, 
	analysiere(hilft, F), write(F), nl,nl,
	
	write('Anfrage 3: analysiere(haelfe, G)'), nl, 
	analysiere(haelfe, G), write(G), nl.	
	
%----------------------------------
% "phrase(Eingabe,Liste)" ist ein zweistelliges Prädikat, welches auf die DCG Regeln zugreift
% und die Eingabe in die festgelgte Listenform generiert bzw. mit der festgelgten 
% Listenform abgleicht.
%
% "akzptiert(Automatenname,Liste Ausgabe" ist dreistelliges Prädikat, welches die Ausgabe aus den
% Automaten hervorruft. - weiteres siehe unten
%
% "analysiere(Eingabe,Ausgabe)" ist ein zweistelliges Prädikat, welches die DCG nutzt, um die
% Eingabe in seine Einzelteile zu teilen und auf die Ausgabe des Automaten zugreift.
%----------------------------------

analysiere(Eingabe,Ausgabe) :- phrase(Eingabe,Liste), akzeptiert(_,Liste,Ausgabe).

%----------------------------------
% "akzeptiert(Name,Liste,Ausgabe)" ist ein dreistelliges Prädikat, welches gespeicherte Informationen
% über die Eingabe heraus gibt.
%----------------------------------

akzeptiert(Name,Liste,Ausgabe) :-
	automat(Name,A),						% Es gibt einen Automaten mit dem Namen "Name".
	A = fst(Start,_,_,_,_,_),					% Dieser wird als 6 stelliges Prädikat dargestellt.
									% fst steht für finite state transductor
									% fsm(Startzustand,Alphabet,Zustände,Ausgabe,Endzustände,Übergänge)
	
	akzeptiert(Name,Liste,Start,Ausgabe).				% Das eigentliche akzeptiert Prädikat ist 4 stellig.
									% Dieses 3 stellige Prädikat lässt den Startzustand weg.
	
%----------------------------------
% trivialer Fall:
% die Eingabeliste ist leer
%----------------------------------

akzeptiert(Name,[],Zustand,Ausgabe) :-	
	automat(Name,A),						% Es gibt einen Automaten mit dem Namen "Name".
	A = fst(_,_,_,Infos,EZ,_),					% Dieser wird als 6 stelliges Prädikat dargestellt.
	ist_enthalten(Zustand,EZ),					% Der Zustand der Eingabeelemente muss in den EndzustŠnden 
									% enthalten sein.
	ist_enthalten(ausgabe(Zustand,Ausgabe),Infos).			% Das 2 stellige Prädikat "ausgabe(Zustand,Ausgabe)"
									% muss in der Menge der Infos des Automaten enthalten sein.
													
									% d.h.:
									% Die Ausgabe befindet sich im Prädikat "ausgabe/2" welches
									% sich in der Menge der Infos im Automaten befindet.
									% Damit auch wirklich eine Ausgabe erfolgt, muss der Automat von
									% einem Startzustand zu einen Endzustand gelangen.
	
%----------------------------------
% rekursiver Fall:
% eine Liste wird akzeptiert, sobald alle Elemente in den †bergŠngen enthalten sind.
%----------------------------------

akzeptiert(Name,[Symbol|Restsymbole],Zustand,Ausgabe) :-
	automat(Name,A),							% Es gibt einen Automaten mit dem Namen "Name".
	A = fst(_,_,_,_,_,Uebergaenge),						% Dieser wird als 6 stelliges Prädikat dargestellt.
	ist_enthalten(uebergang(Zustand,Symbol,					% Ein Übergang mit Zustand, Symbol und NeuemZustand muss in
	NeuerZustand),Uebergaenge),						% der Menge der Übergänge enthalten sein.
												
										% d.h.:
	akzeptiert(Name,Restsymbole,						% Die Eingabe wird akzeptiert, sobald der Zustand und alle
	NeuerZustand,Ausgabe).							% neuen ZustŠnde in den †bergŠngen enthalten sind, 
										% danach folgt die Ausgabe.


%----------------------------------		
% automat(Name,Automat)
%----------------------------------

automat(helfen,fst(
			0,																% 1: Startzustand

			[helf,half,haelf,hilf,hol,ge,fen,en,est,st,e,et,end,t], 				% 2: Alphabet
			
			[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22],				% 3: Zustände
			
														% 4: Ausgabe
			[ausgabe(2,[verb,1,sg,praet,ind]),							% ich half
			ausgabe(2,[verb,3,sg,praet,ind]), 							% er/sie/es half
			ausgabe(4,[verb,imp,sg]),								% hilf!
			ausgabe(7,[verb,part2]),								% geholfen
			ausgabe(8,[verb,2,sg,praes,ind]),							% du hilfst
			ausgabe(9,[verb,3,sg,praes,ind]),							% er/sie/es hilft
			ausgabe(10,[verb,3,pl,praet,konj2]),							% sie hälfen
			ausgabe(10,[verb,1,pl,praet,konj2]),							% wir hälfen
			ausgabe(11,[verb,2,sg,praet,konj2]),							% hŠlfest
			ausgabe(12,[verb,1,sg,praet,konj2]),							% ich hŠlfe
			ausgabe(12,[verb,3,sg,preat,konj2]),							% er/sie/es hälfe
			ausgabe(13,[verb,2,pl,preat,konj2]),							% ihr hälfet
			ausgabe(14,[verb,1,pl,praet,ind]),							% wir halfen
			ausgabe(14,[verb,3,pl,praet,ind]),							% sie halfen
			ausgabe(15,[verb,2,sg,preat,ind]),							% du halfst
			ausgabe(16,[verb,1,pl,praes,ind]),							% wir helfen
			ausgabe(16,[verb,1,pl,praes,konj1]),							% wir helfen
			ausgabe(16,[verb,3,pl,praes,ind]),							% sie helfen
			ausgabe(16,[verb,3,pl,praes,konj1]),							% sie helfen
			ausgabe(17,[verb,1,sg,preas,ind]),							% ich helfe
			ausgabe(17,[verb,1,sg,praes,konj1]),							% ich helfe
			ausgabe(17,[verb,3,sg,praes,konj1]),							% er/sie/es helfe
			ausgabe(18,[verb,part1]),								% helfend 
			ausgabe(19,[verb,2,sg,praes,konj1]),							% du helfest
			ausgabe(20,[verb,2,pl,preas,konj1]),							% ihr helfet
			ausgabe(21,[verb,2,pl,praes,ind]),							% ihr helft
			ausgabe(22,[verb,2,pl,praet,ind])							% ihr halft
			],																
			
			[2,4,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22],					% 5: Endzustände															% 3: Endzustaende
			
			[uebergang(0,helf,1),uebergang(0,half,2),
			uebergang(0,haelf,3),uebergang(0,hilf,4),
			uebergang(0,ge,5),uebergang(1,en,16),
			uebergang(1,e,17),uebergang(1,end,18),
			uebergang(2,en,14),uebergang(2,st,15),
			uebergang(3,en,10),uebergang(3,est,11),
			uebergang(3,e,12),uebergang(3,et,13),
			uebergang(4,st,8),uebergang(4,t,9),
			uebergang(5,holf,6),uebergang(6,en,7),
			uebergang(1,est,19),uebergang(1,et,20),
			uebergang(1,t,21),uebergang(2,t,22)
			])																% 6: Übergänge
		).
		
		
% ZUSATZ-AUFGABE
%----------------------------------
% DCG Regeln 
% Eingabe --> Umformung
%----------------------------------

half 		--> [half].
hilf 		--> [hilf].
geholfen 	--> [ge,holf,en].
hilfst 		--> [hilf,st].
hilft 		--> [hilf,t].
haelfen 	--> [haelf,en].
haelfest 	--> [haelf,est].
haelfe 		--> [haelf,e].
haelfet 	--> [haelf,et].
halfen 		--> [half,en].
halfst 		--> [half,st].
helfen 		--> [helf,en].
helfe 		--> [helf,e].
helfend 	--> [helf,end].
helfest 	--> [helf,est].
helfet 		--> [haelf,et].
helft 		--> [helft].
halft 		--> [halft].

%----------------------------------
% "ist_enthalten(Element,Liste)" ist ein zweistelliges Prädikat, welches schaut,
% ob ein Element in einer Liste enthalten ist.
%----------------------------------

ist_enthalten(E,[E|_]).			% trivialer Fall: das Elemt ist im Kopf der Liste

ist_enthalten(E,[_|R]) :- 		% rekursiver Fall: die Rest Liste wird zur Liste und man schaut sich
		ist_enthalten(E,R).	% erneut den Kopf der Liste an.
