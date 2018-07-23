CREATE TABLE synonyms (
	id INTEGER PRIMARY KEY NOT NULL,
	label VARCHAR(100) NOT NULL UNIQUE
);


CREATE TABLE words (
	id INTEGER PRIMARY KEY NOT NULL,
	word VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE meanings (
	word_id INTEGER,
	synonym_id INTEGER,
	meaning VARCHAR(255) NOT NULL,
	part_of_speech VARCHAR(10) NOT NULL,
	example VARCHAR(255),
	FOREIGN KEY (word_id) REFERENCES words(id),
	FOREIGN KEY (synonym_id) REFERENCES synonyms(id),
	PRIMARY KEY (word_id, synonym_id)
);

INSERT INTO synonyms(id, label)
VALUES
	(1, "Criticize or Express Disapproval of (v.)"),
	(2, "Verbal, Written Attack or Criticsm (n.)"),
	(3, "Trickery, or Being Deceitful"),
	(4, "Hesitate in Choice or Opinion");

INSERT INTO words(id, word)
VALUES 
	(1, "lambaste"),
	(2, "chastise"),
	(3, "censure"),
	(4, "harangue"),
	(5, "assail"),
	(6, "berate"),
	(7, "revile"),
	(8, "castigate"),
	(9, "reprimand"),
	(10, "chide"),
	(11, "reproach"),
	(12, "reprove"),
	(13, "admonish"),
	(14, "denounce"),
	(15, "vituperate"),

	(16, "tirade"),
	(17, "diatribe"),
	(18, "denunciation"),
	(19, "polemic"),
	(20, "broadside"),
	(21, "reproof"),

	(22, "duplicity"),
	(23, "chicanery"),
	(24, "underhandedness"),
	(25, "subterfuge"),
	(26, "intrigue"),
	(27, "cunning"),
	(28, "guile"),
	(29, "artifice"),
	(30, "craft"),
	(31, "mendacity"),
	(32, "stratagem"),

	(33, "dither"),
	(34, "vacillate"),
	(35, "waver");







INSERT INTO meanings(word_id, synonym_id, part_of_speech, meaning, example)
VALUES
	(1, 1, "v.", "to attack verbally", "critics lambasted his performance"),
	(2, 1, "v.", "to censure severely", "The coach chastised the players for their mistakes."),
	(3, 1, "v.", "to find fault with and criticize as blameworthy or to fomrally reprimand (someone)", "While a vote to censure the president has no legal ramifications, it is a significant and rare symbolic vote of disapproval."),
	(4, 1, "v.", "to make a ranting, speech, writing or lecture", "He was haranguing me on the folly of my ways."),
	(5, 1, "v.", "to attack violently or criticize severely", "The politican was assailed by the media."),
	(6, 1, "v.", "to scold or condemn vehemently and at length", "being berated by her parents when she came home late"),
	(7, 1, "v.", "to subject to verbal abuse", "The judge's decision was reviled by the public."),
	(8, 1, "v.", "to subject to severe punishment, reproof, or criticism", "The judge castigated the lawyers for their lack of preparation."),
	(9, 1, "v.", "to reprove sharply or censure formally usually from a position of authority", "While reviewing the troops, the officer delivered a curt reprimand to one of the soldiers."),	
	(10, 1, "v.", "to speak out in angry or displeased rebuke", "The people are quick to chide against the mayor for his negligence."),
	(11, 1, "v.", "to express disappointment in or displeasure with (a person) for conduct that is blameworthy or in need of amendment", "I reproached myself for wasting my summer on unproductive pleasures."),
	(12, 1, "v.", "to scold or correct usually gently or with kindly intent or to express disapproval of", "The teacher reproved the student for being late."),
	(13, 1, "v.", "to express warning or disapproval to especially in a gentle, earnest, or solicitous manner", "We were admonished for being late."),
	(14, 1, "v.", "to pronounce especially publicly to be blameworthy or evil", "They denounced him as a bigot."),
	(15, 1, "v.", "to abuse or censure severely or abusively or to use harsh condemnatory language", "He was vituperated by the neighbors for hosting parties every weekend."),

	(16, 2,	"n.", "a protracted speech usually marked by intemperate, vituperative, or harshly censorious language", "He went into a tirade about the failures of the government."),
	(4,	2, "n.", "a ranting speech or writing", "She delivered a long harangue about the evils of popular culture."),
	(17, 2, "n.", "a bitter and abusive speech or piece of writing; ironic or satirical criticism", "The article is a diatribe against mainstream media."),
	(3, 2, "n.", "a judgment involving condemnation or an official reprimand", "unorthodox practices awaiting the censureof the city council"),
	(18, 2, "n.", "an act of denouncing", "the denunciation of violence"),
	(19, 2, "n.", "an aggressive attack on or refutation of the opinions or principles of another", "Her book is a fierce polemic against the inequalities in our society."),
	(20, 2, "n.", "a very strong and harsh spoken or written attack", "He experienced broadsides against his political views."),
	(21, 2, "n.", "criticism for a fault", "The fear of reproof prevented them from complaining."),

	(22, 3, "n.", "contradictory doubleness of thought, speech, or action, especially the belying of one's true intentions", "She exposed the spy's duplicity."),
	(23, 3, "n.", "deception by artful subterfuge or sophistry", "He wasn't above using chicaneryto win votes."),
	(24, 3, "n.", "dishonest behaviour", "He won the election with underhandedness."),
	(25, 3,	"n.", "deception by artifice or stratagem in order to conceal, escape, or evade; a deceptive device or stratagem", "The same kind of subterfuge that causes employees to open a virus-laden attachment could also lead them to unknowingly install spyware."),
	(26, 3, "n.", "a secret scheme or the practice of engaging in secret schemes", "Within Wall Street lies the nest of intrigue."),
	(27, 3, "n.", "craft, slyness", "He had a look of cunning in the eyes and a curved wrinkle of a hypocrite in the mouth."),
	(28, 3,	"n.", "deceitful cunning", "a war that called for guile rather than firepower"),
	(29, 3,	"n.", "an artful stratagem; false or insincere behavior", "The whole story was just an artifice to win our sympathy."),
	(30, 3, "n.", "skill in deceiving to gain an end", "He used craft and guile to close the deal"),
	(31, 3, "n.", "the quality or state of being characterized by deception or falsehood", "to blow the whistle on mendacity and hypocrisy"),
	(32, 3, "n.", "a cleverly contrived trick or scheme for gaining an end", "We tried various stratagems to get the cat into the carrier, but the feisty feline was wise to them all."),


	(33, 4, "v.", "to act nervously or indecisively", "There's no time to dither as the deadline is tonight."),
	(34, 4, "v.", "to waver in mind, will, or feeling; hesitate in choice of opinions or courses", "He vacillated for so long that someone else stepped in and made the decision."),
	(35, 4, "v.", "to vacillate irresolutely between choices; fluctuate in opinion, allegiance, or direction", "People are still wavering between the two candidates.");


