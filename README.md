# GreSynonymsApp
- iOS app using Swift with MVC design pattern to store flashcards with synonyms, and provide a game to test
- SQLite embedded RDMBS storing words for flashcards and their relations as synonyms
- Normalized design for word database, assigning id's to words and synonyms to minimize data redundancy
- Word and synonym id's and timestamp are used to track performance
- SQLite storing performance and usage data to assist user in choosing what to study and test through ordering synonyms or
  words by different information e.g. order by ratio of mistakes, order by time last tested...
- Below is the current schema for the SQLite database:
  
  ![alt text](https://github.com/csreesan/GreSynonymsApp/blob/master/current_db_schema.png)
