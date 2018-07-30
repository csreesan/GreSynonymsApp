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
	(1, "Criticize/Express Disapproval of (v.)"),
	(2, "Verbal/Written Attack or Criticsm (n.)"),
	(3, "Trickery, or Being Deceitful"),
	(4, "Hesitate in Choice or Opinion"),
	(5, "Talkative"),
	(6, "Boring, Unoriginal"),
	(7, "Arrogant, Self-important"),
	(8, "Imposing Authority/ Insisting Obedience"),
	(9, "Lengthy or Verbose"),
	(10, "Beginning/Young or Growing"),
	(11, "Forshadowing Something Bad"),
	(12, "Irritating or Annoying"),
	(13, "Hard to Understand"),
	(14, "Changing Quickly"),
	(15, "Act of Ruining Somone's Reputation"),
	(16, "Relevant and Appropriate"),
	(17, "Highest Point"),
	(18, "Make Better/Less Intense"),
	(19, "Relating to Countryside"),
	(20, "Immature, Juvenile"),
	(21, "Suffering From Extreme Poverty"),
	(22, "Stingy, Not Spending"),
	(23, "Irratable, In Bad Mood"),
	(24, "Plentiful, More Than Enough");

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
	(36, "excoriate"),

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
	(37, "perfidy"),

	(33, "dither"),
	(34, "vacillate"),
	(35, "waver"),

	(38, "garrulous"),
	(39, "loquacious"),
	(40, "voluble"),
	(41, "gabby"),

	(42, "banal"),
	(43, "jejune"),
	(44, "hackneyed"),
	(45, "insipid"),
	(46, "pedestrian"),
	(47, "prosaic"),
	(48, "quotidian"),
	(49, "trite"),
	(50, "bromidic"),

	(51, "peremptory"),
	(52, "haughty"),
	(53, "conceited"),
	(54, "pompous"),
	(55, "pontifical"),
	(56, "imperious"),
	(57, "overbearing"),
	(58, "supercilious"),

	(59, "imperial"),
	(60, "domineering"),
	(61, "arbitrary"),

	(62, "prolix"),
	(63, "long-winded"),
	(64, "protracted"),
	(65, "rambling"),

	(66, "burgeoning"),
	(67, "inchoate"),
	(68, "incipient"),
	(71, "nascent"),
	(72, "rudimentary"),

	(73, "sinister"),
	(74, "baleful"),
	(75, "ominous"),
	(76, "portentous"),

	(77, "irksome"),
	(78, "vexatious"),
	(79, "galling"),
	(80, "exasperating"),

	(81, "recondite"),
	(82, "abstruse"),
	(83, "obscure"),
	(84, "esoteric"),
	(85, "involved"),
	(86, "opaque"),
	(87, "unfathomable"),
	
	(88, "temperamental"),
	(89, "mercurial"),
	(90, "volatile"),
	(91, "capricious"),
	(92, "fickle"),
	
	(93, "defamation"),
	(94, "calumny"),
	(95, "aspersion"),
	(96, "slander"),
	(97, "vilification"),
	
	(98, "pertinent"),
	(99, "apt"),
	(100, "apposite"),
	(101, "germane"),

	(102, "heyday"),
	(103, "pinnacle"),
	(104, "acme"),
	(105, "apogee"),
	
	(106, "ameliorate"),
	(107, "mitigate"),
	(108, "assuage"),
	(109, "alleviate"),
	(110, "palliate"),
	(111, "abate"),
	
	(112, "bucolic"),
	(113, "pastoral"),
	
	(114, "puerile"),
	(115, "callow"),

	(116, "penurious"),
	(117, "destitute"),
	(118, "impecunious"),
	(119, "indigent"),	

	(120, "parsimonious"),
	(121, "miserly"),
	(122, "frugal"),		
		
	(123, "petulant"),
	(124, "peevish"),
	(125, "pettish"),
	(126, "bilious"),
	(127, "waspish"),
	(128, "irascible"),

	(129, "copious"),
	(130, "ample"),
	(131, "profuse"),
	(132, "fulsome"),
	(133, "bountiful");


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
	(36, 1, "v.", "to censure scathingly", "The candidates have publicly excoriated each other throughout the campaign."),	

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
	(37, 3, "n.", "the quality or state or the act of being faithless or disloyal; deceitfulness", "The perfidy of her husband put an end to their marriage."),

	(33, 4, "v.", "to act nervously or indecisively", "There's no time to dither as the deadline is tonight."),
	(34, 4, "v.", "to waver in mind, will, or feeling; hesitate in choice of opinions or courses", "He vacillated for so long that someone else stepped in and made the decision."),
	(35, 4, "v.", "to vacillate irresolutely between choices; fluctuate in opinion, allegiance, or direction", "People are still wavering between the two candidates."),

	(38, 5, "adj.", "pointlessly or annoyingly talkative", "He became more garrulous after drinking a couple of beers."),
	(39, 5, "adj.", "full of excessive talk", "the loquacious host of a radio talk show"),
	(40, 5, "adj.", "talking a lot in an energetic and rapid way; fluent", "I was quiet while my friend was voluble."),
	(41, 5, "adj.", "talkative", "a gabby talk show host"),


	(42, 6, "adj.", "lacking originality, freshness, or novelty", "He made some banal remarks about the weather."),
	(43, 6, "adj.", "devoid of significance or interest; dull", "She made jejune remarks about life and art."),
	(44, 6, "adj.", "lacking in freshness or originality", "it's hackneyed, but true—the more you save the more you earn"),
	(45, 6,	"adj.", "lacking in qualities that interest, stimulate or challenge; dull, flat", "insipid prose"),
	(46, 6, "adj.", "commonplace, unimaginative", "his sentences and phrases are too often pedestrian, commonplace, and flat"),
	(47, 6, "adj.", "dull, unimaginative", "prosaic advice"),
	(48, 6, "adj.", "commonplace; occuring everyday", "Not content with the quotidian quarrels that other couples had, they had rows that shook the entire neighborhood"),
	(49, 6, "adj.", "boring from much use; not fresh or original", "By the time the receiving line had ended, the bride and groom's thanks sounded trite and tired"),
	(50, 6, "adj.", "lacking in originality", "bromidic talks"),


	(51, 7, "adj.", "characterized by often imperious or arrogant self-assurance or indicative of a peremptory attitude or nature", "His peremptory tone angered me."),	
	(52, 7, "adj.", "blatantly and disdainfully proud; having or showing an attitude of superiority and contempt for people or things perceived to be inferior", "He rejected their offer with a tone of haughty disdain."),
	(53, 7, "adj.", "having or showing an excessively high opinion of oneself", "a brilliant but conceited musician"),
	(54, 7, "adj.", "having or exhibiting self-importance; excessively elevated or ornate", "She found it difficult to talk about her achievements without sounding pompous."),	
	(55, 7, "adj.", "pretentiously dogmatic; pompous", "a theater critic known for his pontifical pronouncements on what is or is not worth seeing"),	
	(56, 7, "adj.", "marked by arrogant assurance", "an imperious movie star who thinks she's some sort of goddess"),
	(57, 7, "adj.", "harshly and haughtily arrogant", "the mayor's overbearing manner of dealing with employees"),	
	(58, 7, "adj.", "coolly and patronizingly haughty", "reacted to their breach of etiquette with a supercilious smile"),

	(51, 8, "adj.", "insisting on immediate attention or obedience", "the governor's peremptory personal assistant began telling the crowd of reporters and photographers exactly where they had to stand"),
	(56, 8, "adj.", "assuming power or authority with no justification", "an imperious little boy who liked to tell the other scouts what to do"),
	(59, 8, "adj.", "of or relating to an empire", "envisioned an imperial city that would rival the capitals of Europe for beauty and magnificence"),
	(60, 8, "adj.", "inclined to exercise arbitrary and overbearing control over others", "the younger children in the family were controlled by a domineering older sister"),
	(61, 8, "adj.", "not restrained or limited in the exercise of power; ruling by absolute authority", "an arbitrary government"),
	(57, 8,	"adj.", "tending to overwhelm; overpowering", "had to deal with his overbearing mother"),

	(62, 9, "adj.", "marked by or using an excess of words; unduly prolonged or drawn out, too long", "The speech was unnecessarily prolix."),
	(63, 9, "adj.", "tediously long in speaking or writing", "a long-winded speaker"),
	(64, 9, "adj.", "lasting for a long time", "protracted dispute"),
	(65, 9,	"adj.", "talk or write in a desultory or long-winded wandering fashion", "rambling speech"),

	(66, 10, "adj.", "growing, expanding, or developing rapidly", "a burgeoning market/industry"),
	(67, 10, "adj.", "not yet fully developed, being only partly in existence or operation", "a still inchoate democratic system"),
	(68, 10, "adj.", "beginning to come into being; initial stage", "an incipient solar system"),
	(71, 10, "adj.", "coming or having recently come into existence", "a nascent middle class"),
	(72, 10, "adj.", "of a primitive kind; undeveloped basic form", "When baseball was in its rudimentary stages, different teams played by different rules."),

	(73, 11, "adj.", "foreshadowing ill fortune or trouble", "the movie relies too much on sinister background music"),
	(74, 11, "adj.", "foreboding or threatening evil", "a dark, baleful sky portending a tornado"),
	(75, 11, "adj.", "being or exhibiting an omen, especially foreshadowing evil", "an ominous threat of war"),
	(76, 11, "adj.", "foreshadowing a coming of an event, usually ominous", "an eerie and portentous stillness hung over the camp the night before the battle"),

	(77, 12, "adj.", "annoying or irritating", "the irksome task of cleaning up"),
	(78, 12, "adj.", "causing annoyance", "those vexatious phone calls from telemarketers during the dinner hour"),
	(79, 12, "adj.", "causing someone to feel angry or annoyed", "This is a galling defeat."),
	(80, 12, "adj.", "causing strong feelings of irritation or annoyance", "an exasperating delay"),

	(81, 13, "adj.", "of, relating to, or dealing with something little known or obscure; difficult or impossible for one of ordinary understanding or knowledge to comprehend", "a recondite subject"),
	(82, 13, "adj.", "difficult to comprehend", "abstruse concepts/ideas/theories"),
	(83, 13, "adj.", "not readily understood or clearly expressed", "a slough of pretentious and obscure jargon"),
	(84, 13, "adj.", "requiring or exhibiting knowledge that is restricted to a small group", "esoteric subjects"),
	(85, 13, "adj.", "marked by extreme and often needless or excessive complexity", "The instructions for assembling the toy are very involved."),
	(86, 13, "adj.", "hard to understand or explain", "Exactly what that future will bring remains opaque."),
	(87, 13, "adj.", "impossible to comprehend", "the unfathomable reaches of space"),

	(88, 14, "adj.", "marked by excessive sensitivity and impulsive mood changes; unpredictable in behavior or performance", "The actor is known for being temperamental."),
	(89, 14, "adj.", "characterized by rapid and unpredictable changeableness of mood",	"a mercurial temper"),
	(90, 14, "adj.", "characterized by or subject to rapid or unexpected change", "a volatile market"),
	(91, 14, "adj.", "changing often and quickly especially in mood or behavior", "employees who are at the mercy of a capricious manager"),
	(92, 14, "adj.", "given to erratic changeableness", "He blames poor sales on fickle consumers."),
				
	(93, 15, "n.", "the act of communicating false statements about a person that injure the reputation of that person", "defamation of character"),
	(94, 15, "n.", "the act of uttering false charges or misrepresentations maliciously calculated to harm another's reputation", "He was the target of calumny for his unpopular beliefs."),
	(95, 15, "n.", "a false or misleading charge meant to harm someone's reputation", "casting aspersions on her integrity"),
	(96, 15, "n.", "the utterance of false charges or misrepresentations which defame and damage another's reputation; a false and defamatory oral statement about a person", "He was a target of slander."),
	(97, 15, "n.", "act of uttering slanderous and abusive statements against",	"warned that the constant vilification of candidates for public office was undermining the people's faith in the political system"),
								
	(98, 16, "adj.", "having a clear decisive relevance to the matter in hand", "he impressed the jury with his concise, pertinent answers to the attorney's questions"),
	(99, 16, "adj.", "suited to a purpose", "an apt quotation"),
	(100, 16, "adj.", "highly pertinent or appropriate", "enriched his essay on patriotism with some very apposite quotations from famous people on the subject"),
	(101, 16, "adj.", "being at once relevant and appropriate", "facts germane to the dispute"),

	(102, 17, "n.",	"the period of one's greatest popularity, vigor, or prosperity", "in its heyday, the circus was a major form of entertainment for small-town America"),
	(103, 17, "n.", "the highest point of development or achievement", "a singer who has reached the pinnacle of success"),
	(104, 17, "n.",	"the highest point or stage", "the acme of his fame"),
	(105, 17, "n.", "the farthest or highest point", "Aegean civilization reached its apogee in Crete."),

	(106, 18, "v.", "to make better or more tolerable", "medicine to ameliorate the pain"),
	(107, 18, "v.", "to make less severe or painful", "mitigate a patient's suffering"),
	(108, 18, "v.", "to lessen the intensity of (something that pains or distresses)", "unable to assuage their grief"),
	(109, 18, "v.",	"to make (something, such as suffering) more bearable", "Her sympathy alleviatedhis distress."),
	(110, 18, "v.", "to moderate the intensity of", "trying topalliate the boredom"),
	(111, 18, "v.", "to reduce in degree or intensity", "may abate their rancor to win peace"),
							
	(112, 19, "adj.", "relating to or typical and pleasant aspects of rural life", "the bucolic landscapes and pastoral grace."),
	(113, 19, "adj.", "of or relating to the countryside", "a pastoral setting"),
					
	(43, 20, "adj.", "juvanile; immature", "jejune behavior"),
	(114, 20, "adj.", "childish, silly", "puerile remarks"),
	(115, 20, "adj.", "lacking adult sophistication, immature", "a story about a callow youth who learns the value of hard work and self-reliance"),

	(116, 21, "adj.", "marked by or suffering from severe poverty", "penurious peasants and fisherfolk"),
	(117, 21, "adj.", "lacking possessions and resources; suffering extreme poverty", "adestitute old man"),
	(118, 21, "adj.", "having very little or no money usually habitually", "they were so impecunious that they couldn't afford to give one another even token Christmas gifts"),
	(119, 21, "adj.", "suffering from extreme poverty", "The clinic provides free care for indigent patients."),

	(116, 22, "adj.", "extremely stingy", "the company's penurious management could not be convinced of the need to earmark more money for research and development"),
	(120, 22, "adj.", "frugal to the point of stinginess", "A society that is parsimonious in its personal charity (in terms of both time and money) will require more government welfare."),
	(121, 22, "adj.", "stingy; of, relating to, or characteristic of a miser", "my brother, who is notoriously miserly, surprised us when he offered to pick up the tab"),
	(122, 22, "adj.", "characterized by or reflecting economy in the use of resources", "a frugal meal of bread and cheese"),
										
	(123, 23, "adj.", "showing suddent impatient irritation, especial on trivial annoyance", "a petulant and fussy man who is always blaming everyone else for his problems"),
	(124, 23, "adj.", "marked by ill temper", "peevish patients in the doctor's waiting room"),
	(125, 23, "adj.", "childishly petulant and bad-tempered", "a pettish baby who always seemed to be crying"),
	(126, 23, "adj.", "irritable; cranky; peevish", "a bilious old dog who snaps at everyone"),
	(127, 23, "adj.", "readily expressing irriation or anger", "extremely waspish, she uses her wit viciously when irritated"),
	(128, 23, "adj.", "marked by hot temper and easily provoked anger", "an irascible old football coach"),
									
	(129, 24, "adj.", "yielding something abundantly; present in large quantity", "a copious harvest"),
	(130, 24, "adj.", "generous or more than adequate in size, scope, or capacity; generously sufficient to satisfy a requirement or need", "They had amplemoney for the trip."),
	(131, 24, "adj.", "exhibiting great abundance", "a profuse harvest"),
	(132, 24, "adj.", "characterized by abundance", "grateful survivors who were fulsome in their praise of the rescue team"),
	(133, 24, "adj.", "given or provided abundantly", "a bountiful harvest");	

