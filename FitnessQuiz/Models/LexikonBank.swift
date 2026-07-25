import Foundation

/// Static reference content for the Lexikon screen, curated as a MoSCoW
/// learning curriculum (must → should → could) rather than just an
/// alphabetical glossary. Sourced from established sports-nutrition
/// fundamentals (general textbooks / ISSN position stands), not tied to
/// single studies — see docs/journal.md for the sourcing decision.
enum LexikonBank {
    static let all: [LexikonEntry] = [
        LexikonEntry(
            id: "kalorienbilanz",
            title: "Kalorienbilanz",
            category: .ernaehrung,
            priority: .must,
            summary: "Das Verhältnis zwischen aufgenommenen und verbrauchten Kalorien – die Grundlage jeder Gewichtsveränderung.",
            details: "Die Kalorienbilanz beschreibt, wie viel Energie du über die Nahrung aufnimmst im Vergleich zu deinem Gesamtenergieverbrauch. Nimmst du weniger Kalorien auf, als du verbrauchst, entsteht ein Kaloriendefizit – der Körper deckt die fehlende Energie aus Reserven (u.a. Fettgewebe), man nimmt ab. Bei einem Kalorienüberschuss ist es umgekehrt. Für Muskelaufbau oder Gewichtsreduktion ist die Kalorienbilanz der wichtigste einzelne Hebel – wichtiger als die genaue Verteilung der Makronährstoffe."
        ),
        LexikonEntry(
            id: "makronaehrstoffe",
            title: "Makronährstoffe",
            category: .ernaehrung,
            priority: .must,
            summary: "Kohlenhydrate, Fette und Proteine – die drei Nährstoffe, die dem Körper Energie liefern.",
            details: "Makronährstoffe sind die Nährstoffe, die in größeren Mengen benötigt werden und Energie (Kalorien) liefern: Kohlenhydrate (ca. 4 kcal/g) und Proteine (ca. 4 kcal/g) liefern etwa gleich viel Energie pro Gramm, Fett liefert mit ca. 9 kcal/g mehr als doppelt so viel. Jeder Makronährstoff hat neben der Energiebereitstellung eigene Funktionen: Kohlenhydrate sind die bevorzugte schnelle Energiequelle, Fette u.a. wichtig für Hormonproduktion und Zellstruktur, Proteine sind der Baustoff für Muskeln und Gewebe."
        ),
        LexikonEntry(
            id: "proteinbedarf",
            title: "Proteinbedarf",
            category: .ernaehrung,
            priority: .must,
            summary: "Kraftsportler brauchen deutlich mehr Protein als die allgemeine Empfehlung für Nicht-Sportler.",
            details: "Während die allgemeine Empfehlung für Erwachsene bei etwa 0,8 g Protein pro Kilogramm Körpergewicht liegt, empfehlen sportwissenschaftliche Positionspapiere für Personen mit regelmäßigem Krafttraining etwa 1,6–2,2 g pro Kilogramm Körpergewicht täglich, um Muskelaufbau und -erhalt optimal zu unterstützen. Höhere Mengen bringen laut aktueller Studienlage kaum zusätzlichen Nutzen. Die Verteilung über mehrere Mahlzeiten am Tag scheint dabei vorteilhaft zu sein."
        ),
        LexikonEntry(
            id: "mikronaehrstoffe",
            title: "Mikronährstoffe",
            category: .ernaehrung,
            priority: .should,
            summary: "Vitamine und Mineralstoffe – lebensnotwendig, aber liefern selbst keine Energie.",
            details: "Im Gegensatz zu Makronährstoffen liefern Mikronährstoffe (Vitamine und Mineralstoffe) keine Kalorien, sind aber essenziell für zahlreiche Körperfunktionen: Calcium und Vitamin D für Knochen, Eisen für den Sauerstofftransport im Blut, B-Vitamine für den Energiestoffwechsel, Magnesium für Muskel- und Nervenfunktion. Eine abwechslungsreiche Ernährung mit ausreichend Obst, Gemüse und Vollkornprodukten deckt bei den meisten Menschen den Bedarf."
        ),
        LexikonEntry(
            id: "aminosaeuren",
            title: "Aminosäuren",
            category: .ernaehrung,
            priority: .should,
            summary: "Die Bausteine von Proteinen – manche kann der Körper selbst herstellen, manche nicht.",
            details: "Proteine bestehen aus Aminosäuren, von denen der menschliche Körper 20 verschiedene für den Aufbau von Muskeln und Gewebe benötigt. Neun davon gelten als essenziell: Der Körper kann sie nicht selbst herstellen, sie müssen über die Nahrung aufgenommen werden (u.a. in Fleisch, Fisch, Eiern, Milchprodukten, Hülsenfrüchten). Die übrigen, nicht-essenziellen Aminosäuren kann der Körper bei Bedarf selbst synthetisieren."
        ),
        LexikonEntry(
            id: "glykaemischer-index",
            title: "Glykämischer Index",
            category: .ernaehrung,
            priority: .should,
            summary: "Ein Maß dafür, wie schnell ein Lebensmittel den Blutzuckerspiegel ansteigen lässt.",
            details: "Der glykämische Index (GI) vergleicht, wie stark und wie schnell ein kohlenhydrathaltiges Lebensmittel den Blutzuckerspiegel im Vergleich zu reiner Glukose (GI = 100) erhöht. Lebensmittel mit hohem GI (z.B. Weißbrot, gesüßte Getränke) lassen den Blutzucker schnell ansteigen und wieder abfallen, Lebensmittel mit niedrigem GI (z.B. Hülsenfrüchte, Vollkornprodukte) tun dies langsamer und gleichmäßiger."
        ),
        LexikonEntry(
            id: "naehrstofftiming",
            title: "Nährstofftiming",
            category: .ernaehrung,
            priority: .should,
            summary: "Die zeitliche Verteilung von Mahlzeiten und Makronährstoffen rund um das Training.",
            details: "Nährstofftiming beschreibt, wann bestimmte Nährstoffe – vor allem Protein und Kohlenhydrate – rund um das Training aufgenommen werden. Früher wurde ein enges 'anaboles Fenster' direkt nach dem Training als entscheidend angesehen; aktuelle Forschung zeigt, dass die Gesamtmenge an Protein und Kalorien über den Tag deutlich wichtiger ist als der exakte Einnahmezeitpunkt."
        ),
        LexikonEntry(
            id: "creatin",
            title: "Creatin",
            category: .ernaehrung,
            priority: .could,
            summary: "Eines der am besten erforschten Nahrungsergänzungsmittel – unterstützt kurze, intensive Belastungen.",
            details: "Creatin ist eine körpereigene Substanz, die auch über Nahrung (v.a. Fleisch, Fisch) und als Nahrungsergänzung aufgenommen werden kann. Es erhöht die Speicher an Creatinphosphat in der Muskulatur, was bei kurzen, intensiven Belastungen (z.B. Krafttraining) schneller Energie bereitstellt. Studien zeigen konsistent leichte Verbesserungen bei Kraft und Muskelmasse im Zusammenhang mit Krafttraining. Übliche Dosierung: 3–5 g täglich, dauerhaft eingenommen – eine anfängliche Aufsättigungsphase ist nicht zwingend nötig."
        ),
        LexikonEntry(
            id: "tef",
            title: "Thermic Effect of Food (TEF)",
            category: .ernaehrung,
            priority: .could,
            summary: "Die Energie, die der Körper selbst für die Verdauung von Nahrung aufwendet.",
            details: "Der Thermic Effect of Food beschreibt den Kalorienverbrauch, der allein durch Verdauung, Aufnahme und Verstoffwechselung von Nahrung entsteht. Er macht etwa 8–15 % des Gesamtenergieverbrauchs aus und unterscheidet sich je Makronährstoff: Protein hat mit ca. 20–30 % den höchsten TEF, gefolgt von Kohlenhydraten (ca. 5–10 %) und Fett (ca. 0–3 %)."
        ),
        LexikonEntry(
            id: "leucin-schwelle",
            title: "Leucin-Schwelle",
            category: .ernaehrung,
            priority: .could,
            summary: "Die Menge der Aminosäure Leucin pro Mahlzeit, die nötig ist, um die Muskelproteinsynthese maximal anzuregen.",
            details: "Leucin ist eine essenzielle Aminosäure mit einer besonderen Rolle: Sie wirkt als eine Art Signalgeber, der die Muskelproteinsynthese anstößt. Die Leucin-Schwelle beschreibt die Menge Leucin pro Mahlzeit (häufig mit ca. 2–3 g angegeben), die nötig ist, um diese Signalwirkung maximal auszulösen – ein Grund, warum tierische Proteinquellen oft als besonders effektiv für den Muskelaufbau gelten."
        ),
        LexikonEntry(
            id: "insulin",
            title: "Insulin",
            category: .ernaehrung,
            priority: .could,
            summary: "Ein Hormon, das die Aufnahme von Nährstoffen in die Zellen steuert.",
            details: "Insulin wird von der Bauchspeicheldrüse ausgeschüttet, wenn der Blutzuckerspiegel steigt. Es ist ein anaboles Hormon: Es fördert die Aufnahme von Glukose und Aminosäuren in die Zellen und hemmt gleichzeitig den Fettabbau. Ein verbreitetes Missverständnis ist, dass Insulin allein für Gewichtszunahme verantwortlich sei – tatsächlich ist die Gesamtkalorienbilanz entscheidend, Insulin steuert primär, wohin Nährstoffe in dieser Bilanz transportiert werden."
        ),

        // Trainingslehre
        LexikonEntry(
            id: "progressive-ueberlastung",
            title: "Progressive Überlastung",
            category: .trainingslehre,
            priority: .must,
            summary: "Der Trainingsreiz muss schrittweise gesteigert werden, damit sich der Körper weiter anpasst.",
            details: "Progressive Überlastung ist das zentrale Prinzip hinter jedem nachhaltigen Trainingsfortschritt: Damit sich Muskeln, Sehnen und das Nervensystem weiter anpassen, muss der Trainingsreiz mit der Zeit gesteigert werden – z.B. durch mehr Gewicht, mehr Wiederholungen, mehr Sätze oder kürzere Pausen. Bleibt der Reiz immer gleich, stagniert der Fortschritt irgendwann, weil der Körper sich vollständig an die bisherige Belastung gewöhnt hat."
        ),
        LexikonEntry(
            id: "trainingsvolumen",
            title: "Trainingsvolumen",
            category: .trainingslehre,
            priority: .must,
            summary: "Die Gesamtbelastung einer Trainingseinheit: Sätze mal Wiederholungen mal Gewicht.",
            details: "Das Trainingsvolumen fasst zusammen, wie viel eine Trainingseinheit oder -woche insgesamt an Belastung liefert – meist berechnet als Sätze × Wiederholungen × Gewicht. Es ist neben der Intensität eine der wichtigsten Stellschrauben für Muskelaufbau: zu wenig Volumen liefert keinen ausreichenden Wachstumsreiz, zu viel Volumen kann die Erholungsfähigkeit übersteigen und die Regeneration verschlechtern."
        ),
        LexikonEntry(
            id: "satz-und-wiederholung",
            title: "Satz & Wiederholung",
            category: .trainingslehre,
            priority: .must,
            summary: "Die Grundbausteine jeder Trainingsplanung: eine Wiederholung, mehrere davon ein Satz.",
            details: "Eine Wiederholung (Rep) ist die einmalige, vollständige Ausführung einer Übung. Mehrere Wiederholungen direkt hintereinander ohne Pause ergeben einen Satz (Set). Trainingspläne werden meist als Kombination aus Sätzen und Wiederholungen pro Übung angegeben, z.B. „3 Sätze à 10 Wiederholungen“ – die Basis, um Trainingsvolumen und -intensität zu steuern."
        ),
        LexikonEntry(
            id: "periodisierung",
            title: "Periodisierung",
            category: .trainingslehre,
            priority: .should,
            summary: "Die systematische Planung von Trainingsreizen über Wochen und Monate.",
            details: "Periodisierung bedeutet, Trainingsintensität und -volumen nicht zufällig, sondern systematisch über einen längeren Zeitraum zu planen und zu variieren. Lineare Modelle steigern die Intensität kontinuierlich über Wochen, undulierende Modelle variieren Intensität und Volumen häufiger, etwa wöchentlich. Ziel ist es, Fortschritt zu ermöglichen und gleichzeitig Übertraining zu vermeiden."
        ),
        LexikonEntry(
            id: "rpe-rir",
            title: "RPE & RIR",
            category: .trainingslehre,
            priority: .should,
            summary: "Zwei Skalen, um die tatsächliche Trainingsintensität eines Satzes einzuschätzen.",
            details: "RPE (Rate of Perceived Exertion) bewertet, wie anstrengend sich ein Satz subjektiv anfühlt, meist auf einer Skala von 1 bis 10. RIR (Repetitions in Reserve) gibt an, wie viele Wiederholungen bis zum Muskelversagen theoretisch noch möglich gewesen wären. Beide Skalen helfen dabei, die Trainingsintensität gezielt zu steuern, ohne bei jedem Satz bis zum vollständigen Muskelversagen zu trainieren."
        ),
        LexikonEntry(
            id: "superkompensation",
            title: "Superkompensation",
            category: .trainingslehre,
            priority: .could,
            summary: "Nach ausreichender Erholung steigt die Leistungsfähigkeit kurzfristig über das Ausgangsniveau.",
            details: "Nach einer Trainingsbelastung sinkt die Leistungsfähigkeit zunächst durch die entstandene Ermüdung. Mit ausreichender Erholung steigt sie anschließend für eine gewisse Zeit über das ursprüngliche Niveau – dieses Prinzip heißt Superkompensation. Trifft die nächste Trainingseinheit genau in dieses Zeitfenster, kann sich die Leistungsfähigkeit stetig steigern; zu viel oder zu wenig Erholung schwächt diesen Effekt ab."
        ),
        LexikonEntry(
            id: "overtraining",
            title: "Overtraining Syndrome",
            category: .trainingslehre,
            priority: .could,
            summary: "Chronische Leistungsminderung durch dauerhaft unzureichende Erholung.",
            details: "Das Overtraining Syndrome entsteht, wenn die Trainingsbelastung über längere Zeit die Erholungsfähigkeit des Körpers übersteigt. Anzeichen sind anhaltende Leistungsminderung, erhöhte Verletzungsanfälligkeit, Schlafprobleme und allgemeine Erschöpfung. Die Lösung ist in der Regel eine deutliche Reduktion von Volumen und Intensität über mehrere Wochen, bevor das Training wieder gesteigert wird."
        ),

        // Übungsausführung
        LexikonEntry(
            id: "neutrale-wirbelsaeule",
            title: "Neutrale Wirbelsäule",
            category: .uebungsausfuehrung,
            priority: .must,
            summary: "Die Grundlage sicherer Technik bei fast jeder Kraftübung mit Gewicht.",
            details: "Eine neutrale Wirbelsäule bedeutet, die natürlichen Krümmungen des Rückens beizubehalten, ohne ihn übermäßig zu runden oder ins Hohlkreuz zu gehen. Das gilt besonders bei Übungen mit Gewicht am oder über dem Körper wie Kreuzheben, Kniebeuge oder Rudern: eine neutrale Wirbelsäule verteilt die Belastung gleichmäßiger und schützt die Bandscheiben vor einseitiger Druckbelastung."
        ),
        LexikonEntry(
            id: "range-of-motion",
            title: "Range of Motion (ROM)",
            category: .uebungsausfuehrung,
            priority: .must,
            summary: "Die Bewegungsstrecke, die eine Übung tatsächlich durchläuft.",
            details: "Range of Motion beschreibt, wie weit sich ein Gelenk oder eine Muskelgruppe während einer Übung bewegt – von der Start- bis zur Endposition. Eine größere Range of Motion (z.B. eine tiefe statt einer halben Kniebeuge) beansprucht die Muskulatur meist über einen größeren Bereich und gilt für den Muskelaufbau tendenziell als effektiver, sofern die Technik dabei sauber bleibt."
        ),
        LexikonEntry(
            id: "aufwaermen-technik",
            title: "Aufwärmen vor dem Training",
            category: .uebungsausfuehrung,
            priority: .must,
            summary: "Leichte, vorbereitende Bewegung senkt das Verletzungsrisiko und verbessert die Leistungsfähigkeit.",
            details: "Aufwärmen bereitet Muskulatur, Gelenke und das Herz-Kreislauf-System auf die kommende Belastung vor. Typisch sind leichte allgemeine Bewegung (z.B. lockeres Cardio), gefolgt von übungsspezifischen Aufwärmsätzen mit geringerem Gewicht. Das senkt das Verletzungsrisiko und verbessert häufig auch die Leistung im eigentlichen Arbeitssatz."
        ),
        LexikonEntry(
            id: "exzentrisch-konzentrisch",
            title: "Exzentrisch & Konzentrisch",
            category: .uebungsausfuehrung,
            priority: .should,
            summary: "Die zwei Phasen jeder Wiederholung: Absenken und Hochdrücken.",
            details: "Bei einer exzentrischen Kontraktion verlängert sich der Muskel unter Spannung, etwa beim kontrollierten Absenken in die Kniebeuge. Bei einer konzentrischen Kontraktion verkürzt sich der Muskel unter Spannung, etwa beim Hochdrücken aus der Kniebeuge. Beide Phasen tragen zum Muskelaufbau bei – die exzentrische Phase gilt dabei oft als besonders reizstark und wird bewusst verlangsamt trainiert."
        ),
        LexikonEntry(
            id: "kreuzheben-technik",
            title: "Kreuzheben-Technik",
            category: .uebungsausfuehrung,
            priority: .should,
            summary: "Neutrale Wirbelsäule, Bewegungseinleitung aus der Hüfte und aktives Anspannen des Rumpfes.",
            details: "Beim Kreuzheben wird die Bewegung aus der Hüfte eingeleitet, nicht aus dem unteren Rücken. Eine neutrale Wirbelsäule und aktives Anspannen der Rumpfmuskulatur (Bracing) stabilisieren die Wirbelsäule während des Hebens. Die Stange bleibt dabei möglichst nah am Körper, um den Hebelarm auf den unteren Rücken zu minimieren."
        ),
        LexikonEntry(
            id: "sticking-point",
            title: "Sticking Point",
            category: .uebungsausfuehrung,
            priority: .could,
            summary: "Die schwächste Position in der Bewegungsbahn einer Übung.",
            details: "Der Sticking Point ist die Position innerhalb einer Bewegung, an der die geringste Kraft aufgebracht werden kann – oft in einem bestimmten Gelenkwinkel. Er bestimmt häufig, wie viel Gewicht insgesamt bewältigt werden kann, unabhängig davon, wie stark man an anderen Punkten der Bewegung ist. Gezieltes Training dieser Position, etwa mit Teilwiederholungen, kann helfen, den Sticking Point zu überwinden."
        ),
        LexikonEntry(
            id: "bracing",
            title: "Bracing",
            category: .uebungsausfuehrung,
            priority: .could,
            summary: "Aktives Anspannen der Rumpfmuskulatur zur Stabilisierung der Wirbelsäule.",
            details: "Bracing beschreibt das bewusste Anspannen der gesamten Rumpfmuskulatur, ähnlich als würde man sich auf einen Schlag in den Bauch vorbereiten. Es stabilisiert die Wirbelsäule während schwerer Übungen wie Kreuzheben oder Kniebeuge und wird typischerweise mit einer tiefen Einatmung vor dem Satz kombiniert (Valsalva-Manöver)."
        ),
    ]

    static func entry(for slug: String?) -> LexikonEntry? {
        guard let slug else { return nil }
        return all.first { $0.id == slug }
    }
}
