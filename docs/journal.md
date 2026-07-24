# Entwicklungsjournal

## 2026-07-24 22:00 – Projektstart & Architektur-Entscheidungen
Tags: [entscheidung, session]
Kriterium: [prozess]

- Was: Aufgabenstellung 1 (Quiz-App) für DLAMSD01 gewählt, Thema Fitness-Wissens-Quiz (Trainingslehre/Ernährung/Übungsausführung) festgelegt.
- Warum: Klarster Scope der drei Aufgabenstellungen, thematische Nähe zu einem möglichen späteren DLAMSD02-Projekt (Tracking-App), ohne Code zu teilen.
- Entscheidung: SwiftUI + einfaches MVVM statt TCA, da der Prüfungsleitfaden kein Architektur-Pattern verlangt, sondern übersichtlichen Code nach Swift-API-Guidelines – ein zusätzliches Framework hätte hier keinen Mehrwert für die Bewertung.
- Entscheidung: Funktionsumfang "Mittel" – Schwierigkeitsstufen + Wiederholung falsch beantworteter Fragen.
- Ressource: bestehendes Claude-Design-System "GreenDarkFitness" wird für einen individuellen Look übernommen und für den Quiz-Kontext uminterpretiert (Violett statt Rot für falsche Antworten).
