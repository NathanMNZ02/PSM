La struttura del progetto Android è la seguente:

/MyCurrency/ In questa cartella troveremo tutto il contenuto del nostro progetto

/MyCurrency/app/src/main/java/com/NHNUniversity/MyCurrency:
Contiente le Activity dell'applicazione, in questo caso ne è stata usata solo una, lo switch tra le pagine è fatto tramite i fragment

/MyCurrency/app/src/main/java/com/NHNUniversity/MyCurrency/Fragment:
Contiene i fragment dell'applicazione:
- MainView_Fragment--> l'app si apre direttamente sul interfaccia per fare il cambio di valute ed esso è permesso da questo fragment.
- History_Fragment--> permette all'utente di prende il tasso di cambio tra due valute in una determinata data (il progetto richiedeva l'history di una settimana prima, ma essendo che l'API me lo permette ho fatto un history più estesa).

/MyCurrency/app/src/main/java/com/NHNUniversity/MyCurrency/Model:
- APIManager-->permette di inviare API e ricevere dati (per farlo uso un meccanismo di callback).
- Currecy-->rappresenta la valuta.
- ICallback-->interfaccia per rappresentare la callback.
- JsonManager-->equivalente al jsonManager di iOS permette di serializzare e deserializzare.

/MyCurrency/app/src/main/res/drawable:
Contiene le immagini usate nell'app.


/MyCurrency/app/src/main/res/layout:
Contiene i vari layout usati nell'app.
