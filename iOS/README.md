La struttura del progetto iOS è la seguente:

/PlaceRemimder/
In questa cartella troveremo tutto il contenuto del nostro progetto

/PlaceReminder/Resource
Immagini usate per l'applicazione (in questo caso solo il logo è stato utilizzato sia come sfondo del main e sia come sfondo del launch dell'app)

/PlaceReminder/Classes
Contiene il modello dell'applicazione:
- MPAllert--> permette di lanciare gli allert per l'utente in modo semplice
- MPFileManager--> permette di lavorare sui file
- MPGeocoder--> permette di fare le operazioni di revese e forward geocoding
- MPJsonManager--> permette di fare operazioni di serialize e deserialize dei JSON
- MPLocation --> contiene il modello di una location.
- MPLocations--> container per le varie locations.

/PlaceReminder/ViewController
Contiene i vari ViewController dell'applicazione:
- MainViewController--> si occupa di attivare le attività in background (Controllo di ingresso e uscita da una regione e invio della notifica), di eliminare tutte le locations, di richiedere le autorizzazioni necessarie 
e di fare il passaggio tra i viewController.
- AddLocationView--> si occupa dell'aggiunta di nuove location.
- LocationTableViewController--> si occupa di mostrare le nuove locatione e eventualmente di elminarle scegliendole
- DetailsViewController--> si occupa di mostrare sulla mappa la locations selezionata e di accedere ai suoi dettagli.

/PlaceReminder/Categories
- Contiente l'estensione della classe MPLocation, fatta per far si che essa possa rappresentare un annotazione
