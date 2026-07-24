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
