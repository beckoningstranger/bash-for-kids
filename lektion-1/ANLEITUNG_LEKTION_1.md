# Lektion 1 – Terminal-Spiel: Schatzsuche 🗺️💎

Willkommen! Heute spielst du eine Schatzsuche – aber nur mit dem Terminal.

Du liest diese Anleitung mit: less ANLEITUNG.md
(Wenn du in less bist: Space = runter, b = hoch, q = beenden)

----------------------------------------

1) Spiel vorbereiten (Start-Muster)

Du bist im Ordner: lektion-1

Starte das Spiel so (genau so eintippen):

bash bereit-spiel-vor.sh

Das baut die Ordner und versteckt den Schatz.

----------------------------------------

2) Spiel starten

Nach dem Vorbereiten gibt es einen Ordner namens: spiel

Wechsle hinein:

cd spiel

Jetzt geht’s los!

----------------------------------------

Ziel 🎯

Du musst eine Datei finden, die so heißt:

schatz.txt

Wenn du sie findest, lies sie (eine von beiden Varianten reicht):

cat schatz.txt

oder

less schatz.txt

Wenn du mir die Nachricht daraus sagen kannst, hast du gewonnen! 🏆

----------------------------------------

Erlaubte Befehle (und wofür sie gut sind)

pwd
- Zeigt: Wo bin ich gerade? (aktueller Ordner)

ls
- Zeigt: Was liegt hier? (Dateien und Ordner)

ls -l
- Zeigt: Mehr Infos (Details)

ls -a
- Zeigt: Auch „versteckte“ Dateien (später wichtig!)

cd NAME
- Geht in einen Ordner hinein
Beispiel: cd wald

cd ..
- Geht einen Ordner zurück (nach oben)

cat DATEI
- Zeigt den Inhalt einer Datei
Beispiel: cat schatz.txt

less DATEI
- Liest eine Datei, man kann scrollen
Beispiel: less schatz.txt
In less: Space = runter, b = hoch, q = beenden

----------------------------------------

Spiel-Tipps 🧠

Tipp 1: Arbeite systematisch
Mach immer diesen Ablauf:
1. pwd  (wo bin ich?)
2. ls   (was gibt es hier?)
3. cd ... (geh in einen Ordner)
4. ls   (was gibt es dort?)
5. wenn du schatz.txt siehst → cat oder less

Tipp 2: Wenn du dich verläufst
Einfach zurück:
cd ..
Dann wieder schauen:
ls

----------------------------------------

Ende ✅

Du hast gewonnen, wenn du:
1) schatz.txt findest
2) sie mit cat oder less liest
3) mir die Nachricht daraus sagst 😄

Viel Erfolg!
Du kannst less mit "q" verlassen!
