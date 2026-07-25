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
    ]

    static func entry(for slug: String?) -> LexikonEntry? {
        guard let slug else { return nil }
        return all.first { $0.id == slug }
    }
}
