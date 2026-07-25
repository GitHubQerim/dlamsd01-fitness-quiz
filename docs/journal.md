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
