# Entwicklungsjournal

## 2026-07-24 22:00 – Projektstart & Architektur-Entscheidungen
Tags: [entscheidung, session]
Kriterium: [prozess]

- Was: Aufgabenstellung 1 (Quiz-App) für DLAMSD01 gewählt, Thema Fitness-Wissens-Quiz (Trainingslehre/Ernährung/Übungsausführung) festgelegt.
- Warum: Klarster Scope der drei Aufgabenstellungen, thematische Nähe zu einem möglichen späteren DLAMSD02-Projekt (Tracking-App), ohne Code zu teilen.
- Entscheidung: SwiftUI + einfaches MVVM statt TCA, da der Prüfungsleitfaden kein Architektur-Pattern verlangt, sondern übersichtlichen Code nach Swift-API-Guidelines – ein zusätzliches Framework hätte hier keinen Mehrwert für die Bewertung.
- Entscheidung: Funktionsumfang "Mittel" – Schwierigkeitsstufen + Wiederholung falsch beantworteter Fragen.
- Ressource: bestehendes Claude-Design-System "GreenDarkFitness" wird für einen individuellen Look übernommen und für den Quiz-Kontext uminterpretiert (Violett statt Rot für falsche Antworten).

## 2026-07-24 23:00 – MVP implementiert: Design-System, Datenmodell, ViewModel, Views
Tags: [feature, problem, session]
Kriterium: [transfer, qualität, prozess]

- Was: Xcode-Projekt (via XcodeGen, `project.yml` als Quelle), Design-System-Tokens/-Komponenten (Colors/Typography/Spacing/Radius/Motion + DSButton/DSCard/DSChip/DSProgressRing/DSStatTile), 45 Fragen (3 Kategorien × 3 Schwierigkeiten × 5), QuizViewModel (Filter/Score/Wiederholungsrunde/High-Score) und die drei Screens (StartView, QuizView, ResultView) implementiert und im Simulator verifiziert.
- Problem: Manrope liegt bei Google Fonts nur noch als Variable-Font-Datei vor (keine einzelnen Weight-Dateien). Lösung: eine `Manrope[wght].ttf` eingebunden und pro Typo-Rolle das exakte Gewicht über die `wght`-Variationsachse (`UIFontDescriptor` + `kCTFontVariationAttribute`) gesetzt, statt fünf separate Dateien zu registrieren.
- Problem: `Font(uiFont:)` ignoriert Dynamic Type. Lösung: `UIFontMetrics(forTextStyle: .body).scaledFont(for:)` vor dem Wrapping in `Font`, damit alle Typo-Rollen mit der Systemschriftgröße mitskalieren.
- Problem (im Simulator-Screenshot entdeckt): Der Kategorie-Chip "Übungsausführung" brach auf zwei Zeilen um und wurde dadurch höher als die Geschwister-Chips. Lösung: Kategorie-Chips in ein horizontales `ScrollView` mit `.fixedSize()` verpackt, analog zur scrollbaren Chip-Reihe im Quell-Design-System.
- Ressource: eigenes Claude-Design-System-Projekt "GreenDarkFitness" (JSX/CSS-Tokens) als Vorlage für Farben, Typografie, Spacing, Radius und Komponentenverhalten (Button/Card/Chip/ProgressRing/StatTile).
- Reflexion: Der reine `xcodebuild`-Build-Check allein hätte den Chip-Zeilenumbruch nicht gefunden – erst der Simulator-Screenshot hat das Layoutproblem sichtbar gemacht. Für den Bericht relevant: visuelle Verifikation ist bei UI-Arbeit kein optionaler Schritt.

## 2026-07-24 23:15 – Code-Review (8 Perspektiven) vor der Abgabe an den Nutzer
Tags: [problem, entscheidung, session]
Kriterium: [qualität, prozess]

- Was: Vor der Übergabe an den Nutzer lief ein mehrperspektivischer Code-Review über den kompletten Feature-Branch-Diff (Korrektheit, entfernte Invarianten, Cross-File-Aufrufe, Reuse, Simplifizierung, Effizienz, Architektur-Tiefe, CLAUDE.md-Konventionen).
- Problem: `ResultView` zeigte "Neuer Bestwert!" auch bei einem bloßen Gleichstand mit dem bisherigen Bestwert, weil der Vergleich erst nach dem Überschreiben des UserDefaults-Werts stattfand. Lösung: `QuizViewModel.finishQuiz()` vergleicht jetzt gegen den alten Wert, bevor er überschrieben wird, und publiziert `isNewHighScore` explizit.
- Problem: Der "Weiter"-Button konnte bei einem sehr schnellen Doppel-Tap theoretisch eine Frage überspringen. Lösung: ein `NextButton`-Wrapper mit `.id(question.id)` blockt einen zweiten Tap pro Frage, ohne die Mehrzweck-Funktion `advanceToNextQuestion()` (auch fürs Laden der ersten Frage genutzt) selbst zu sperren.
- Aufgeräumt: Kategorie-/Bericht-Header-Wash war in StartView und ResultView dupliziert (→ `DSWashedScreen`), `QuizView`s Antwort-Kacheln bauten `DSCard`s Form doppelt nach (→ `DSCard` um `background`/`borderColor` erweitert), nie genutzte Varianten (`DSButtonVariant.light/.ghost`, `DSButtonSize.md`, `DSCardTone.inset`) entfernt (YAGNI), `DSFont.score` war deklariert aber nirgends verdrahtet (jetzt im Ergebnis-Ring verwendet).
- Ergänzt: VoiceOver-`.isSelected`-Trait auf den Auswahl-Chips (fehlte komplett).
- Verifiziert: Alle Fixes per Simulator-Screenshot geprüft, inkl. eines automatisierten Voll-Durchlaufs (Start → Wiederholungsrunde → Ergebnis) über einen temporären Debug-Hook, der danach wieder entfernt wurde – bestätigt u.a., dass der Gleichstand-Fall jetzt korrekt keinen "Neuer Bestwert!"-Banner mehr zeigt.

## 2026-07-25 14:30 – Playtest-Feedback: Antworten waren erratbar
Tags: [problem, entscheidung, session]
Kriterium: [qualität, prozess]

- Was: Beim ersten echten Durchspielen (nach Freiräumen von Speicherplatz – die App war zuvor wegen vollem Datenträger nicht startbar) fiel auf: die richtige Antwort stand fast immer an erster Stelle und war oft die längere/vollständigere Formulierung.
- Ursache: Beim Schreiben der 45 Fragen wurde die richtige Antwort aus Lesbarkeitsgründen immer zuerst notiert (`correctAnswerIndex: 0` bei 38 von 45 Fragen = 84%) und oft als vollständiger Satz, während Distraktoren knapp gehalten wurden.
- Lösung: `Question.shuffled()` mischt die Antwortreihenfolge zur Laufzeit und mappt `correctAnswerIndex` neu; `QuizViewModel.startQuiz()` wendet das auf jede Frage der Runde an. Zusätzlich wurden bei ~15 Fragen die Distraktoren umformuliert, damit auch die Antwortlänge kein verlässliches Muster mehr ist.
- Verifiziert: Direkter Logik-Check über einen temporären Debug-Hook (300 simulierte Runden, immer Antwort-Index 0 gewählt) – vorher deterministisch 4/5 richtig durch das Muster, nachher variiert der Score zufällig zwischen den Läufen, wie bei echtem Raten erwartet.
- Reflexion: Ein Playtest durch eine echte Person (statt nur automatisierter Build-/Logik-Checks) hat ein Qualitätsproblem aufgedeckt, das kein Unit-Test oder Code-Review von selbst gefunden hätte, da der Code technisch korrekt war – nur die Dateninhalte waren einseitig strukturiert.

## 2026-07-25 15:00 – Feature: Erklärungen im Quiz + Lexikon-Screen
Tags: [feature, entscheidung, ressource, session]
Kriterium: [transfer, kreativität, qualität]

- Was: Auf Nutzerwunsch ergänzt: (1) jede Frage bekommt eine kurze Erklärung, die nach dem Beantworten angezeigt wird, (2) ein eigener Lexikon-Screen zum Nachlesen von Ernährungsgrundlagen, (3) Verlinkung von passenden Quizfragen zum jeweiligen Lexikon-Eintrag ("Mehr erfahren").
- Entscheidung – Content-Priorisierung nach MoSCoW: Die 11 Lexikon-Einträge sind explizit als Lern-Fahrplan sortiert, nicht alphabetisch. *Must* (Fundamentals, zuerst lernen): Kalorienbilanz, Makronährstoffe, Proteinbedarf. *Should* (Vertiefung): Mikronährstoffe, Aminosäuren, glykämischer Index, Nährstofftiming. *Could* (Extras): Creatin, Thermic Effect of Food, Leucin-Schwelle, Insulin. Begründung: für jemanden, der sich Ernährungswissen neu aneignet, ist die Reihenfolge wichtiger als Vollständigkeit – erst die Kalorienbilanz verstehen, dann Details.
- Entscheidung – Quellen: allgemeine, etablierte Sporternährungs-Grundlagen (u.a. Positionspapiere der International Society of Sports Nutrition, Standardlehrbücher) als Sammelquelle im Literaturverzeichnis, kein Beleg pro Einzelfakt – passt zu unstrittigem, breit anerkanntem Wissen (keine Aussagen zu kontroverser/neuer Forschung).
- Entscheidung – Navigation: bewusst per `.sheet` statt eines neuen App-weiten `NavigationStack` gelöst (Lexikon-Liste hat einen eigenen internen NavigationStack für Liste→Detail). Das ist genau die Grenze des Phasen-Switch-Ansatzes, die beim Code-Review schon als möglicher künftiger Bedarf benannt wurde – hier gezielt mit der leichtgewichtigeren Lösung (Sheets) statt eines großen Navigations-Refactorings adressiert.
- Reflexion: Das Feature macht die App zu einem echten Lerntool statt reinem Abfrage-Tool – direkt relevant für die Bewertungskriterien Qualität ("hilft die App tatsächlich, die Aufgabe zu lösen?") und Kreativität.

## 2026-07-25 16:15 – Dashboard-Redesign des Start-Screens
Tags: [feature, entscheidung, session]
Kriterium: [kreativität, qualität]

- Was: Auf Vorschlag des Nutzers `StartView` von einer linearen Liste (Header, Lexikon-Button, Chips, Bestwert, Start-Button untereinander) zu einem Karten-Dashboard umgebaut: eine Full-Width-Karte "Quiz" (Kategorie/Schwierigkeit/Bestwert/Start-Button gebündelt) und darunter eine Zeile mit zwei halbbreiten Karten ("Lexikon", "Über dieses Projekt").
- Entscheidung: Layout lehnt sich bewusst an das Karten-Raster des ursprünglichen GreenDarkFitness-Dashboards an (Metric-Tiles im 2-Spalten-Grid) – gute Konsistenz zur Design-System-Quelle, obwohl unsere Quiz-App kein Dashboard im ursprünglichen (Fitness-Tracker-)Sinn hat.
- Ressource: zusätzliches Lucide-Icon "heart-pulse" aus dem Design-Projekt für die "Über dieses Projekt"-Karte ergänzt (gleiches Vorgehen wie bei den bisherigen 7 Icons: SVG kopieren, Template-Rendering aktivieren).

## 2026-07-25 16:20 – Lexikon-Inhaltslücke geschlossen
Tags: [problem, feature, session]
Kriterium: [qualität, transfer]

- Problem: Beim Testen fiel auf, dass das Lexikon nur Ernährungsthemen abdeckte – ein Filter auf Trainingslehre oder Übungsausführung zeigte eine leere, unerklärte Fläche.
- Lösung: 14 neue Einträge nach demselben MoSCoW-Schema ergänzt (7 Trainingslehre: progressive Überlastung, Trainingsvolumen, Satz & Wiederholung, Periodisierung, RPE & RIR, Superkompensation, Overtraining; 7 Übungsausführung: neutrale Wirbelsäule, Range of Motion, Aufwärmen, exzentrisch/konzentrisch, Kreuzheben-Technik, Sticking Point, Bracing). Zusätzlich ein Empty-State-Text als Fallback, falls eine Kategorie/Filter-Kombination doch mal leer sein sollte.

## 2026-07-25 17:00 – Polish-Runde: drei kleine, aber lehrreiche UI-Bugs
Tags: [problem, entscheidung, session]
Kriterium: [qualität, prozess]

- Problem 1 (sichtbare Naht im Verlauf): Der Header-Wash zeigte im Lexikon (als eigenständiges Sheet präsentiert) eine sichtbare Kante dort, wo der 220pt-Verlauf endet. Ursache: `DSWashedScreen` hatte selbst keinen vollflächigen Hintergrund und verließ sich auf den Hintergrund der umgebenden View – das funktioniert bei StartView/ResultView (weil `ContentView` schon `surfaceBase` vollflächig malt), aber nicht bei einem eigenständig präsentierten Sheet, das seinen eigenen System-Hintergrund mitbringt. Lösung: `DSWashedScreen` malt jetzt selbst zuerst `surfaceBase` vollflächig, dann den Verlauf darüber.
- Problem 2 (Karten-Höhe): Die zwei Dashboard-Kacheln sollten exakt gleich hoch sein, unabhängig vom Textinhalt und der Systemschriftgröße. Eine feste `minHeight`-Konstante reichte nicht (bei unterschiedlich langem Text wächst nur eine Karte, die andere bleibt kürzer). Lösung: `PreferenceKey`-basierte Höhen-Messung (`DashboardTileHeightKey`, `reduce` nimmt das Maximum) – beide Karten melden ihre natürliche Höhe, die größere gewinnt, beide bekommen diesen Wert als `minHeight` zurück. Klassisches SwiftUI-Muster zum Höhen-Angleichen von Geschwister-Views ohne gemeinsamen Elternknoten mit fester Größe. Bei der größtmöglichen Bedienungshilfen-Schriftgröße bleibt in der kürzeren Karte sichtbarer Leerraum – bewusst akzeptierter Kompromiss (Leerraum statt abgeschnittenem Text).
- Problem 3 (fehlendes App-Icon): Nur ein leerer Icon-Slot war hinterlegt. Lösung: Icon programmatisch mit CoreGraphics erzeugt (Marken-Hintergrund + Mint-Kurzhantel-Silhouette aus einfachen Rechtecken/Rundungen). Wichtig dabei: kein Alpha-Kanal (`CGImageAlphaInfo.noneSkipLast`), sonst schlägt Apples Icon-Validierung fehl.
- Problem 4 (Absturz auf echtem Gerät): App stürzte beim Start auf einem echten iPhone ab (im Simulator lief sie einwandfrei), Xcode zeigte nur einen nicht aussagekräftigen Low-Level-Trap ohne Swift-Stackframe. Wahrscheinliche Ursache: `DEVELOPMENT_TEAM` in `project.yml` ist leer – für den Simulator unproblematisch, für Code-Signing auf einem echten Gerät aber nötig. Nutzer gebeten, in Xcode unter "Signing & Capabilities" sein Team auszuwählen; im Simulator weiterverifiziert, während das offen ist.
- Kleinere Anpassung: Begrüßungstext und Titel im Dashboard-Header vergrößert (`DSFont.body` bzw. `DSFont.score` statt `label`/`greeting`), damit der Screen wirklich wie ein Dashboard-Header wirkt statt wie eine einfache Listen-Überschrift.

## 2026-07-25 17:15 – Anforderungs-Check gegen die Aufgabenstellung
Tags: [entscheidung, session]
Kriterium: [prozess, qualität]

- Was: Vor dem ersten Commit des Gesamtstands systematisch gegen die Aufgabenstellung DLAMSD01/1.1 geprüft: eigenes Anwendungsgebiet, Prototyp, begründete Funktionsentscheidungen, übersichtlicher Code mit Funktionen/geeigneten Datenstrukturen, Einhaltung der Swift-API-Design-Guidelines, dokumentierbare Verknüpfung von Nutzerinteraktion und Programmreaktion, Screenshot-Fähigkeit.
- Ergebnis: Code-seitig sind alle Pflichtanforderungen erfüllt. Die einzig verbleibende große Aufgabe ist der Projektbericht selbst (noch nicht begonnen). Der Funktionsumfang (Erklärungen, Lexikon, Dashboard) geht bewusst über das geforderte Minimum hinaus – gutes Material für die Bewertungskriterien Kreativität und Qualität im Bericht.
