# Journal-Kontext

## Kurs
DLAMSD01 – Apple Mobile Solution Development I (IU Internationale Hochschule)

## Aufgabenstellung
Aufgabenstellung 1: "Train-your-Brain" – Entwicklung einer Quiz-App für die iOS-Plattform, Anwendungsgebiet frei wählbar.

Gewählt: **Fitness-Wissens-Quiz** (Kategorien: Trainingslehre, Ernährung, Übungsausführung).

## Mindestanforderungen (aus der Aufgabenstellung)
- [ ] Quiz-App für iOS, eigenes Anwendungsgebiet
- [ ] Ideen/Konzept dargestellt, erster Prototyp entworfen
- [ ] Entscheidungen zu Funktionen und UI-Gestaltung begründet
- [ ] Code übersichtlich & verständlich (Funktionen, geeignete Datenstrukturen, Swift-API-Design-Guidelines)
- [ ] Aufbau der App-Oberfläche in Xcode dokumentiert
- [ ] Swift-Logik zur Steuerung der App dokumentiert (Code-Ausschnitte)
- [ ] Verknüpfung Nutzerinteraktion ↔ Programmreaktion erläutert
- [ ] Funktionsweise durch ausgewählte Screenshots demonstriert

## Gewählter Funktionsumfang ("Mittel")
- Schwierigkeitsstufen je Kategorie (leicht/mittel/schwer)
- Wiederholung falsch beantworteter Fragen am Ende der Runde
- Punktesystem + High-Score-Persistenz pro Kategorie (UserDefaults)

## Architektur-Entscheidung
Einfaches SwiftUI + MVVM, keine TCA – Begründung: Prüfungsleitfaden verlangt kein bestimmtes Architektur-Pattern, sondern "übersichtlichen, leicht verständlichen" Code nach Swift-API-Design-Guidelines. Ein zusätzliches Architektur-Framework hätte für ein Kurs-Projekt dieser Größe eher gegen dieses Kriterium gearbeitet.

## Design-System
Ressource: eigenes Claude-Design-System-Projekt "GreenDarkFitness" (near-black UI, ein Mint-Grün-Akzent, Violett nur für negative Werte, Manrope-Font), ursprünglich für eine Workout-Tracking-App entworfen und für dieses Quiz uminterpretiert (u.a. Violett statt Rot für falsch beantwortete Fragen, da das System kein Ampel-Farbschema kennt). Relevant für die Bewertungskriterien Transfer und Kreativität.

## Bewertungskriterien (Prüfungsleitfaden)
Transfer, Dokumentation, Ressourcen, Prozess, Kreativität, Qualität – je jeweils dokumentieren, insbesondere Prozess (fortlaufend) und Kreativität (Design-System-Adaption, eigene Fragenkatalog-Idee).
