```diff

 Legenda
  biały - nikt nad tym aktualnie nie pracuje
- czerowny - ktoś aktualnie nad tym pracuje
+ zielony - zrobione

 PROJEKT SYSTEMY OPERACYJNE
 Napisz skrypt realizujący konto bankowe. Na wstępie skrypt odpytuje użytkownika o login i
 hasło. Login oraz hasło powinny byd z walidowane tzn login powinien składad się tylko z liter a hasło z
 cyfr całkowitych. Po zalogowaniu do konta skrypt pokaże nam saldo konta oraz zebrane oszczędności
 oraz łączną kwotę konta.
 Funkcje jakie powinny byd zawarte oprócz wstępnych po zalogowaniu :
 


 Finanse

+ 1. Sprawdzenie wszystkich kont
+ 2. Subkonto 
+ 3. Konto oszczędnościowe
+ 4. Karty płatnicze 
+ 5. Pożyczki 


  Usługi 
+ 1. Odbiorcy ( Lista odbiorców których można dodawad lub usuwad. Dodawanie nowego
+ odbiorcy polega na dodaniu danych osobowych oraz numeru konta )
+ 2. Zaplanowane płatności ( Lista zaplanowanych płatności )
+ 3. Stałe zlecenia ( Lista zleceo wykonywanych co miesiąc, można je dodawad i ustawiad
+ odpowiednią kwotę, dane osobowe lub firmowe i numer konta )
+ 4. Cele oszczędnościowe ( Utworzenie wirtualnego dodatkowego konta do którego można
+ ustawid comiesięczny automatyczny przelew lub można samemu przelewad. Należy to
+ ustawid oraz obliczyd ile czasu nam zajmie zgromadzenie odpowiedniej kwoty )
+ 5. Raty ( Produkty które zostały wzięte na raty [Nazwa produktu, Gdzie został wzięty, Koszt, raty
+ jakie wynoszą w okresie] ) 
+ 6. Dokumenty ( Dokumenty gromadzone przez użytkownika [ Możliwośd stworzenia pliku z
+ danymi txt ] )  
+ 7. Zaświadczenia ( zaświadczenia gromadzone przez użytkownika [ Możliwośd stworzenia pliku z
+ danymi txt ] )  
+ 8. Doładowanie telefonu 
+ 9. Kantor ( Zamiana waluty PLN na dowolną z wybranych z listy [ PROSZĘ UWZGLĘDNIĆ 10
+ WALUT DOWOLNYCH ] )  

 Oferta
+ 1. Konto osobiste ( Informacje o koncie, założenie dodatkowego konta, subkonta itd )
+ 2. Oszczędności ( Sprawdzenie ile oszczędności klient posiada oraz pokazanie czasu ile
+ klientowi zajmie zgromadzenie odpowiedniej sumy ) [w koncie oszczędnościowym] & Konrad ma swoje
+ 3. Kredyty ( Możliwośd wzięcia kredytu na odpowiednią ilośd lat lub miesięcy, Kwota
+ powinna byd dodawana do głównego konta. Informacja jaka powinna zostad zwrócona
+ po przyznaniu kredytu powinna byd obliczana z korzyścią dla banku + 6% [RRSO] ) 
+ 4. Kredyty i pożyczki ( Informacje o kredytach oraz pożyczkach jakie klient posiada [Gdzie,
+ kiedy, ile zostało wzięte, z jakiego banku] ) 
+ 5. Karty i płatności telefonem ( Informacje o kartach oraz powiązanych telefonach z usługą
+ BLIK [Zabezpieczony numer karty tzn sześd wartości oraz dalej ******* lub trzy
+ początkowe wartości numeru telefonu z *****, model telefonu powiązany], zamówienie
+ nowej karty lub powiązanie nowego telefonu ) 
+ 6. Emerytura ( Obliczenie kwoty emerytury po składkach ) 
+ 7. Ubezpieczenie ( Informacje o ubezpieczeniu lub dodanie nowego ubezpieczenie np. na
+ telefon lub rodzinę [ Proszę ująd tutaj 10 przykładów jakichkolwiek z ubezpieczeniami ] ) 
+ 8. Rozliczenie z ZUS ( Obliczenie i ustawienie przelewu do ZUS’u [ Należy mied go
+ zadeklarowanego w stałych odbiorcach ] ) -
+ 9. Leasing ( Informacje o leasingach lub rozpoczęcie nowego po wypełnieniu formularza [
+ Proszę stworzyd formularz wczytywany z klawiatury Imię, Nazwisko, pesel <walidacja>,
+ numer telefonu <walidacja>, Kwota leasingu, wybranie czasu miesięcy np. 12,24,36,72 ,
+ Kwota + 9%[ RRSO ] do oddania dla banku] ) 
+ 10. Terminale płatnicze ( Informacje o najbliższych terminalach w okolicy ) 



  Historia 
+ 1. Sprawdzenie płatności przelewów (Data, numer konta, kwota, do kogo, możliwośd
+ generowania .txt do katalogu Konto na pulpicie wraz z nazwą pliku
+ data_numerTransakcji.txt ) 


 Wykonaj transakcje 
+ 1. Przelew zwykły ( Podanie danych osobowych + numeru konta oraz kwoty, następnie
+ powinno pojawid się uwierzytelnienie i zapytanie po wykonaniu przelewu czy się zgadza
+ czy też nie. Pojawienie się informacji powinno się pojawid gdy wartośd przelewu jest
+ większa niż 50 PLN ). Każda transakcja powinna przelewad na konto oszczędnościowe 3
+ PLN po wykonaniu przelewu. 
+ 2. Przelew ekspres (Podanie danych osobowych + numeru konta oraz kwoty, następnie
+ powinno pojawid się uwierzytelnienie i zapytanie po wykonaniu przelewu czy się zgadza
+ czy też nie. Pojawienie się informacji powinno się pojawid gdy wartośd przelewu jest
+ większa niż 50 PLN ) dodatkowo proszę doliczyd 10 zł za wykonanie tego przelewu. Każda
+ transakcja ekspres powinna przelewad na konto oszczędnościowe 5 PLN po wykonaniu
+ przelewu. 
+ 3. Przelew walutowy (Podanie danych osobowych + numeru konta oraz kwoty wraz z
+ ustawieniem waluty, następnie powinno pojawid się uwierzytelnienie i zapytanie po
+ wykonaniu przelewu czy się zgadza czy też nie. Pojawienie się informacji powinno się
+ pojawid gdy wartośd przelewu jest większa niż 50 PLN ) dodatkowo proszę doliczyd 20 zł
+ za wykonanie tego przelewu. Każda transakcja walutowa powinna przelewad na konto
+ oszczędnościowe 10 PLN po wykonaniu przelewu. Informacją zwrotna powinna
+ wyświetlad przeliczoną kwotę na PLN ile upłynęło z konta. 
```
