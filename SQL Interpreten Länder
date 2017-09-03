
select

--*

count(t1.artistid) as "Anzahl vertretener Länder",--zählen der artitistID pro Land aus der t1 
--t1.artistid as "Interpreten ID",
t1.Name as "Interpret"--Umbenennung der Spalte Name in Interpret
 
from 
    (select 

    albums.artistid , 
    artists.Name,
    invoices.BillingCountry --Auswahl dieser drei Spalten ...

    from 
    albums--...der Tabelle albums...

    inner join artists on albums.Artistid = artists.ArtistId
    inner join tracks on albums.albumId = tracks.albumid
    inner join invoice_items on tracks.trackid = invoice_items.trackid
    inner join invoices on invoices.invoiceid = invoice_items.invoiceid--...gejoint mit den Tabellen artists, tacks, invoice_items und invoiceid um über diese Reihe artistID aus der Tabelle artists mit BillingCountry aus der Tabelle invoiceID verknüpfen zu können

    group by albums.artistid, invoices.BillingCountry, artists.Name--zusmamengefasst nach diesen kriterien
    ) as t1

group by t1.artistid, t1.Name--zusammengefasst nach diesen Kriterien
order by count(t1.artistid)desc--sortiert nach nach den gezählten Ländern, angefangen mit dem größten Ergebnis
